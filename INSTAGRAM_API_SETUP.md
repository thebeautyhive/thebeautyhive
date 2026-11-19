# Instagram API Auto-Update Setup Guide

## 🎉 Your widget is now ready for auto-updates!

Follow this guide to connect it to your real Instagram account. Takes about **15-20 minutes** one time.

---

## 📋 What You'll Get

✅ **Automatic post updates** from your Instagram
✅ **Real likes & comment counts**
✅ **Direct links to original Instagram posts**
✅ **Caches posts for 1 hour** (reduces API calls)
✅ **Falls back to manual posts** if API fails

---

## 🚀 Step-by-Step Setup

### Step 1: Create a Facebook App (5 minutes)

1. **Go to Facebook Developers**: https://developers.facebook.com/
2. **Log in** with your Facebook account (the one connected to your Instagram business account)
3. **Click "My Apps"** in the top right
4. **Click "Create App"**
5. Select **"Consumer"** as the app type
6. Fill in:
   - **App Name**: `Beauty Hive Instagram Feed` (or any name)
   - **App Contact Email**: Your email
7. **Click "Create App"**

### Step 2: Add Instagram Basic Display (3 minutes)

1. In your new app dashboard, scroll down to **"Add Products"**
2. Find **"Instagram Basic Display"** and click **"Set Up"**
3. Scroll down and click **"Create New App"**
4. Fill in the form (replace `yourdomain.com` with your actual website URL):
   - **Display Name**: `Beauty Hive Feed`
   - **Valid OAuth Redirect URIs**: `https://yourdomain.com/`
   - **Deauthorize Callback URL**: `https://yourdomain.com/`
   - **Data Deletion Request URL**: `https://yourdomain.com/data-deletion.html`
5. **Click "Save Changes"**

> **Important URLs**: I've created `privacy-policy.html` and `data-deletion.html` in your `/public` folder. Once your site is live, use those URLs above.

### Step 3: Add Instagram Tester (2 minutes)

1. Scroll down to **"User Token Generator"**
2. Click **"Add or Remove Instagram Testers"**
3. You'll be redirected to the App Roles page
4. Under **"Instagram Testers"**, click **"Add Instagram Testers"**
5. **Enter your Instagram username**: `isssbeenails`
6. Click **"Submit"**

### Step 4: Accept Tester Invitation (2 minutes)

1. **Open Instagram** (mobile app or web: https://www.instagram.com/)
2. Go to **Settings** → **Apps and Websites** → **Tester Invites**
3. **Accept the invitation** from your app

> **Note**: This must be done from the Instagram account `isssbeenails`

### Step 5: Generate Access Token (3 minutes)

1. Go back to your **Facebook App Dashboard**
2. Go to **Products** → **Instagram Basic Display** → **Basic Display**
3. Under **"User Token Generator"**, find your Instagram account
4. Click **"Generate Token"**
5. **Authorize the app** when Instagram prompts you
6. **Copy the Access Token** (long string of characters)

⚠️ **IMPORTANT**: Keep this token secret! Don't share it publicly.

### Step 6: Add Token to Your Website (2 minutes)

1. Open `public/index.html` in your code editor
2. Find line **846** (around there) that looks like:
   ```javascript
   const INSTAGRAM_CONFIG = {
       accessToken: '', // ADD YOUR ACCESS TOKEN HERE
   ```
3. **Paste your token** between the quotes:
   ```javascript
   const INSTAGRAM_CONFIG = {
       accessToken: 'YOUR_LONG_ACCESS_TOKEN_HERE',
   ```
4. **Save the file**
5. **Refresh your website** - posts should now load from Instagram! 🎉

---

## ✅ Testing It Works

1. Open your website in a browser
2. **Open the browser console** (F12 or Right-click → Inspect → Console)
3. Look for messages:
   - ✅ `🔄 Fetching fresh posts from Instagram API...`
   - ✅ `✅ Successfully fetched X posts from Instagram`
4. **You should see your real Instagram posts!**

### If You See Manual Posts Instead:

- Check console for error messages
- Verify your access token is correct
- Make sure your Instagram account is a **Business or Creator account**
- Verify the tester invitation was accepted

---

## 🔄 Token Refresh (Important!)

### Short-lived tokens expire in 1 hour
To get a **long-lived token** (60 days), make this API call:

1. Open this URL in your browser (replace `YOUR_TOKEN` and `YOUR_APP_SECRET`):
   ```
   https://graph.instagram.com/access_token?grant_type=ig_exchange_token&client_secret=YOUR_APP_SECRET&access_token=YOUR_TOKEN
   ```

2. Get your **App Secret** from:
   - Facebook App Dashboard → Settings → Basic → App Secret

3. You'll get a response with a `access_token` that lasts 60 days

4. Use this new token in your `INSTAGRAM_CONFIG`

### Auto-refresh (Optional)

You can refresh the token automatically before it expires. Let me know if you want me to add this feature!

---

## ⚙️ Configuration Options

In `public/index.html` around line **845**, you can customize:

```javascript
const INSTAGRAM_CONFIG = {
    accessToken: 'YOUR_TOKEN',
    userId: '', // Auto-detected, leave empty
    postsLimit: 25, // How many posts to fetch (max 25 per request)
    cacheExpiry: 3600000 // Cache duration in ms (1 hour = 3600000)
};
```

### Adjust Cache Duration:
- **1 hour**: `3600000` (default - recommended)
- **6 hours**: `21600000`
- **24 hours**: `86400000`
- **No cache**: `0` (will fetch every page load - not recommended)

---

## 🔧 Troubleshooting

### "Using manual posts (no access token provided)"
- You haven't added your access token yet
- Token is empty or incorrect

### "Instagram API error: 400"
- Token is invalid or expired
- Get a new token (Step 5)

### "Instagram API error: 190"
- Token expired
- Refresh your token (see Token Refresh section)

### Posts not updating
- Clear browser cache (Ctrl+Shift+R or Cmd+Shift+R)
- Clear localStorage: Open Console → Type `localStorage.clear()` → Press Enter
- Refresh page

### Only some posts showing
- Instagram API only returns public posts
- Carousel posts (multiple images) show as single post
- Videos are filtered out (only images supported currently)

---

## 🆚 Fallback Behavior

Your widget is smart! It will:

1. ✅ **Try Instagram API first**
2. ✅ **Use cached posts** if available (faster, reduces API calls)
3. ✅ **Fall back to manual posts** if API fails
4. ✅ **Show console messages** so you know what's happening

The manual posts in your code act as a **backup** - your widget will never break!

---

## 🎓 Advanced: Want Videos Too?

Currently, the widget only fetches images. If you want video posts:

1. Find line **1015** in `index.html`
2. Change:
   ```javascript
   .filter(post => post.media_type === 'IMAGE' || post.media_type === 'CAROUSEL_ALBUM')
   ```
   To:
   ```javascript
   .filter(post => post.media_type === 'IMAGE' || post.media_type === 'CAROUSEL_ALBUM' || post.media_type === 'VIDEO')
   ```

Videos will use `thumbnail_url` for the grid and open Instagram when clicked.

---

## 💡 Pro Tips

1. **First time setup**: Use a short-lived token to test, then get long-lived token
2. **Set a reminder** to refresh your token every 60 days
3. **Monitor the console** first few times to ensure it's working
4. **Cache helps**: Less API calls = faster loading + less likely to hit rate limits

---

## 📞 Need Help?

Common issues and solutions:

| Problem | Solution |
|---------|----------|
| Token won't generate | Make sure Instagram is a Business/Creator account |
| Tester invite not showing | Wait 5 minutes, refresh Instagram settings |
| API returns empty array | Check if your posts are public |
| Cross-origin errors | This is normal for some setups, use cache to minimize |

---

## 🎉 You're All Set!

Once your token is added, your Instagram feed will:
- ✅ Update automatically with new posts
- ✅ Show real engagement numbers
- ✅ Link directly to Instagram
- ✅ Work offline with cached posts
- ✅ Never break (falls back to manual posts)

**Enjoy your free, auto-updating Instagram feed!** 🎊
