# Custom Instagram Feed Widget - User Guide

## 🎉 Your Custom Instagram Widget is Ready!

I've replaced the Elfsight widget with a **completely custom, zero-cost solution** that gives you MORE features without any pricing limitations!

## ✨ Features You Now Have

### 1. **Profile Header**
- Profile picture
- Username
- Follower/Following counts
- Bio text
- Direct "Follow on Instagram" button

### 2. **Multiple View Modes**
- **Grid View**: Classic Instagram grid (default)
- **Masonry View**: Pinterest-style staggered layout
- **List View**: Full posts with captions visible

### 3. **Interactive Features**
- Hover to see likes & comments
- Click any post to view in a beautiful modal/lightbox
- "Load More" button for pagination
- Smooth animations and transitions
- Mobile responsive design

### 4. **No Limitations**
- ✅ Unlimited views
- ✅ Unlimited posts
- ✅ No branding
- ✅ Full customization control
- ✅ No monthly fees EVER

## 📝 How to Update Your Instagram Feed

### Updating Profile Information

Find this section in `public/index.html` (around line 843):

```javascript
const instagramProfile = {
    username: '@isssbeenails',
    profilePicUrl: 'https://placehold.co/150x150/6C544E/FFFFFF?text=TBH',
    postsCount: 124,
    followersCount: 1847,
    followingCount: 312,
    bio: '✨ Professional Nail Artist<br>💅 Gel-X | Acrylics | Builder Gel | Pedicures<br>📍 San Diego, CA<br>🔗 Book your appointment below!',
    instagramUrl: 'https://instagram.com/isssbeenails'
};
```

**To Update:**
1. Change `profilePicUrl` to your actual profile picture URL
2. Update `postsCount`, `followersCount`, `followingCount` with your current numbers
3. Edit the `bio` text (use `<br>` for line breaks)
4. Update `instagramUrl` with your Instagram profile link

### Adding New Posts

Find the `instagramPosts` array (around line 855). To add a new post, copy this template:

```javascript
{
    id: 13,  // Increment this number for each new post
    type: 'image',  // or 'video' if it's a video post
    imageUrl: 'https://your-image-url.com/image.jpg',
    caption: 'Your caption here with emojis! 💅 #hashtag',
    likes: 150,
    comments: 20,
    date: '2025-10-05'  // Format: YYYY-MM-DD
}
```

**Example: Adding a New Post**

```javascript
const instagramPosts = [
    // Add your newest post at the top:
    {
        id: 13,
        type: 'image',
        imageUrl: 'https://i.imgur.com/NEWIMAGE.jpeg',
        caption: 'Check out this amazing new set! 💖✨ #nailart #beautyhive',
        likes: 234,
        comments: 45,
        date: '2025-10-05'
    },
    // ... existing posts below
];
```

### Where to Get Image URLs

You have several options:

1. **Imgur** (Recommended - Free & Easy)
   - Upload image to [imgur.com](https://imgur.com)
   - Right-click image → "Copy image address"
   - Use the direct link (ending in .jpg or .png)

2. **Your Website Hosting**
   - Upload to `/public/images/` folder
   - Reference as: `./images/your-image.jpg`

3. **Instagram Direct Links**
   - Not recommended (Instagram may block external access)

## 🎨 Customization Tips

### Changing Colors

The widget uses your site's existing color scheme:
- Accent color: `#C0A99A` (brown/beige)
- Primary brown: `#6C544E`
- Instagram gradient: Purple → Pink → Orange (for buttons)

To change colors, search for these values in the CSS section (around line 176-360).

### Adjusting Layout

**Grid Columns**: Find line 258-274 to change number of columns:
```css
.insta-grid-view {
    grid-template-columns: repeat(4, 1fr); /* Change 4 to your desired number */
}
```

**Initial Posts Shown**: Find line 968:
```javascript
let displayedPostsCount = 8; // Change to show more/fewer posts initially
```

**Posts Loaded Per Click**: Find line 1154:
```javascript
displayedPostsCount += 8; // Change how many posts load when clicking "Load More"
```

## 🚀 Advanced Features You Can Add

Since you own this code, you can easily add:
- Filter by hashtags
- Search functionality
- Video support (already built-in, just add posts with `type: 'video'`)
- Sort by date/popularity
- Infinite scroll instead of "Load More" button
- Animation effects
- And literally anything else you want!

## 📱 Mobile Responsive

The widget automatically adjusts for:
- Mobile phones (2 columns)
- Tablets (3 columns)
- Desktop (4 columns)

## 🆚 Comparison with Elfsight

| Feature | Elfsight Free | Elfsight Basic ($10/mo) | Your Custom Widget |
|---------|---------------|-------------------------|-------------------|
| Views Limit | 200/month | 5,000/month | ♾️ UNLIMITED |
| Widgets | 1 | 3 | ♾️ UNLIMITED |
| Branding | ❌ Has branding | ✅ No branding | ✅ No branding |
| Customization | Limited | Limited | ✅ FULL CONTROL |
| Cost | Free | $120/year | **$0 FOREVER** |
| Multiple Layouts | ❌ | ❌ | ✅ 3 layouts |
| Lightbox Modal | Basic | Basic | ✅ Advanced |
| Load More | ❌ | Limited | ✅ Yes |

## 🐛 Troubleshooting

**Posts not showing?**
- Check that image URLs are valid and accessible
- Make sure JavaScript console shows no errors (F12 in browser)

**Layout looks weird?**
- Clear browser cache (Ctrl+Shift+R or Cmd+Shift+R)
- Check that all closing brackets `}` and braces are properly matched

**Want to test changes?**
- Open the HTML file in your browser
- Make changes in your code editor
- Refresh the page to see updates

## 💡 Need Help?

The widget is built with vanilla JavaScript - no dependencies, no frameworks, no complications. All the code is in one file for easy maintenance!

---

**Enjoy your new, completely free Instagram feed widget!** 🎉
