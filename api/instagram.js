// Vercel Serverless Function - Instagram Feed
// This fetches Instagram posts and serves them to your widget

// In-memory cache (resets on cold start, which is fine)
let cache = {
  data: null,
  timestamp: 0
};

const CACHE_DURATION = 3600000; // 1 hour in milliseconds

export default async function handler(req, res) {
  // Enable CORS for your domain
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  // Handle preflight
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  // Only allow GET requests
  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    // Check cache first
    const now = Date.now();
    if (cache.data && (now - cache.timestamp) < CACHE_DURATION) {
      console.log('✅ Serving from cache');
      return res.status(200).json({
        success: true,
        cached: true,
        posts: cache.data
      });
    }

    // Get Instagram credentials from environment variables
    const accessToken = process.env.INSTAGRAM_ACCESS_TOKEN;

    if (!accessToken) {
      console.error('❌ No Instagram access token configured');
      return res.status(500).json({
        error: 'Instagram access token not configured',
        message: 'Please add INSTAGRAM_ACCESS_TOKEN to your Vercel environment variables'
      });
    }

    console.log('🔄 Fetching fresh data from Instagram API...');

    // Fetch from Instagram Graph API
    const instagramResponse = await fetch(
      `https://graph.instagram.com/me/media?fields=id,caption,media_type,media_url,thumbnail_url,permalink,timestamp,like_count,comments_count&access_token=${accessToken}&limit=25`
    );

    if (!instagramResponse.ok) {
      const errorData = await instagramResponse.json();
      console.error('❌ Instagram API error:', errorData);
      return res.status(instagramResponse.status).json({
        error: 'Instagram API error',
        details: errorData
      });
    }

    const data = await instagramResponse.json();

    // Transform Instagram data to our format
    const transformedPosts = data.data
      .filter(post => ['IMAGE', 'VIDEO', 'CAROUSEL_ALBUM'].includes(post.media_type))
      .map((post, index) => ({
        id: index + 1,
        type: post.media_type === 'VIDEO' ? 'video' : 'image',
        imageUrl: post.media_type === 'VIDEO' ? post.thumbnail_url : post.media_url,
        videoUrl: post.media_type === 'VIDEO' ? post.media_url : null,
        caption: post.caption || '',
        likes: post.like_count || 0,
        comments: post.comments_count || 0,
        date: post.timestamp.split('T')[0],
        permalink: post.permalink
      }));

    // Update cache
    cache.data = transformedPosts;
    cache.timestamp = now;

    console.log(`✅ Successfully fetched ${transformedPosts.length} posts`);

    return res.status(200).json({
      success: true,
      cached: false,
      posts: transformedPosts,
      count: transformedPosts.length
    });

  } catch (error) {
    console.error('❌ Error fetching Instagram data:', error);
    return res.status(500).json({
      error: 'Failed to fetch Instagram data',
      message: error.message
    });
  }
}
