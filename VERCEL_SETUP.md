# 🚀 Vercel Instagram Backend Setup

Your Instagram widget now uses a **serverless backend** on Vercel! This means you get automatic Instagram updates without exposing API tokens to the browser.

---

## 📋 What Was Created

✅ **`/api/instagram.js`** - Vercel serverless function that fetches Instagram data
✅ **`vercel.json`** - Vercel configuration
✅ **`.gitignore`** - Prevents committing sensitive files
✅ **Widget updated** - Now fetches from `/api/instagram` instead of directly from Instagram

---

## 🎯 Setup Steps (10 minutes)

### Step 1: Get Instagram Graph API Token

Since Instagram Basic Display is deprecated, we need to use **Instagram Graph API**:

**Requirements**:
- Instagram **Business Account** (or Creator)
- Connected to a **Facebook Page**

**Don't have these yet?** See "Convert Account" section below.

**Already have Business account + Page?** Continue to Step 2.

---

### Step 2: Get Long-Lived Access Token

**Option A: Use Facebook Graph API Explorer** (Easiest)

1. Go to: https://developers.facebook.com/tools/explorer/
2. Select your app: `3049515258561101`
3. Click "Generate Access Token"
4. Select permissions:
   - `instagram_basic`
   - `pages_show_list`
   - `pages_read_engagement`
5. Click "Generate Token"
6. Copy the token
7. Convert to long-lived token (see Step 3)

**Option B: Manual Authorization Flow**

See detailed instructions in `INSTAGRAM_API_SETUP.md` (Graph API section)

---

### Step 3: Convert to Long-Lived Token (60 days)

**Get your App Secret**:
1. Go to: https://developers.facebook.com/apps/3049515258561101/settings/basic/
2. Click "Show" on App Secret
3. Copy it

**Exchange for long-lived token**:

Open this URL (replace placeholders):
```
https://graph.facebook.com/v18.0/oauth/access_token?grant_type=fb_exchange_token&client_id=3049515258561101&client_secret=YOUR_APP_SECRET&fb_exchange_token=YOUR_SHORT_TOKEN
```

**You'll get**:
```json
{
  "access_token": "LONG_LIVED_TOKEN",
  "token_type": "bearer",
  "expires_in": 5184000
}
```

Copy the `access_token` - this lasts **60 days**!

---

### Step 4: Add Token to Vercel

**In Vercel Dashboard**:

1. Go to your project: https://vercel.com/
2. Click your project (`thebeautyhive`)
3. Go to **Settings** → **Environment Variables**
4. Add a new variable:
   - **Name**: `INSTAGRAM_ACCESS_TOKEN`
   - **Value**: Your long-lived token (paste here)
   - **Environments**: Select all (Production, Preview, Development)
5. Click **"Save"**

---

### Step 5: Deploy to Vercel

**If already connected to Vercel**:
```bash
git add .
git commit -m "Add Instagram backend API"
git push
```

Vercel will auto-deploy!

**If NOT connected yet**:
```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy
vercel
```

Follow the prompts!

---

### Step 6: Test Your API

Once deployed, test your API endpoint:

**Your API URL**: `https://yourdomain.vercel.app/api/instagram`

**Test in browser**: Just open that URL, you should see:
```json
{
  "success": true,
  "cached": false,
  "posts": [...],
  "count": 25
}
```

---

### Step 7: Update Widget & Deploy

Your widget is already updated to use the backend API!

1. Remove the Elfsight widget code (lines 578-580 in `index.html`)
2. Add the custom widget HTML from `CUSTOM_WIDGET_BACKUP.html`
3. Uncomment the JavaScript init (line ~1386)
4. Deploy!

---

## 🔄 Convert Instagram to Business Account

**If you need to convert `@isssbeenails`**:

### Method 1: Via Instagram App

1. Open Instagram app
2. Go to Profile → Menu (≡) → Settings
3. Tap **"Account"**
4. Tap **"Switch to Professional Account"**
5. Choose **"Business"**
6. Follow setup wizard
7. Connect to Facebook Page (create one if needed)

### Method 2: Via Facebook

1. Go to: https://www.facebook.com/pages/create
2. Create a Facebook Page for your business
3. Go to Page Settings → Instagram
4. Connect `@isssbeenails`
5. Instagram will auto-convert to Business

---

## 📱 Local Development (Optional)

**To test locally**:

1. Create `.env.local` file:
   ```
   INSTAGRAM_ACCESS_TOKEN=your_token_here
   ```

2. Install Vercel CLI:
   ```bash
   npm install -g vercel
   ```

3. Run locally:
   ```bash
   vercel dev
   ```

4. Open: http://localhost:3000

---

## 🔐 Security Features

Your backend API has:
- ✅ **Token hidden** - Never exposed to browser
- ✅ **CORS enabled** - Works from your domain
- ✅ **Caching** - 1 hour cache (reduces API calls)
- ✅ **Error handling** - Graceful fallbacks
- ✅ **Rate limit friendly** - Caching prevents hitting limits

---

## 📊 How It Works

```
┌─────────┐     ┌──────────────┐     ┌───────────┐
│ Browser │────▶│ Vercel API   │────▶│ Instagram │
│ (User)  │◀────│ /api/instagram│◀────│ Graph API │
└─────────┘     └──────────────┘     └───────────┘
                   (Your Backend)
```

1. User visits your site
2. Widget calls `/api/instagram`
3. Vercel function fetches from Instagram (with token)
4. Returns posts to widget
5. Widget displays beautiful feed!

---

## 💰 Cost Analysis

**Vercel Free Tier Includes**:
- 100GB bandwidth/month
- 100 hours serverless execution/month
- Automatic HTTPS

**Your API Usage** (estimated):
- ~1KB per request
- ~10ms execution time
- With 1-hour caching: ~720 requests/month
- **= 0.7MB bandwidth, 7 seconds execution**

**You won't even come close to limits!** ✅

---

## 🔄 Token Refresh (Every 60 Days)

Set a calendar reminder for 50 days from now:

1. Generate new short-lived token (Step 2)
2. Convert to long-lived (Step 3)
3. Update in Vercel environment variables (Step 4)
4. Done! (No redeployment needed - env vars update automatically)

---

## 🐛 Troubleshooting

### API returns error about token
- Check Vercel environment variable is set correctly
- Verify token hasn't expired (60 days)
- Generate new token

### "Access token not configured"
- Token not set in Vercel environment variables
- Check variable name is exactly: `INSTAGRAM_ACCESS_TOKEN`

### Posts not showing
- Check browser console for errors
- Test API directly: `https://yourdomain.com/api/instagram`
- Verify Instagram account is Business/Creator

### "CORS error"
- Check `vercel.json` is deployed
- Verify domain matches

---

## ✅ Verification Checklist

- [ ] Instagram account is Business/Creator
- [ ] Connected to Facebook Page
- [ ] Got long-lived access token (60 days)
- [ ] Added token to Vercel environment variables
- [ ] Deployed to Vercel
- [ ] Tested API endpoint
- [ ] Widget updated to use backend
- [ ] All features working!

---

## 🎉 Success!

Once setup, you have:
- ✅ Automatic Instagram updates
- ✅ No exposed API tokens
- ✅ Free hosting (Vercel)
- ✅ All premium widget features
- ✅ No monthly costs
- ✅ Professional backend architecture

**You now have a production-grade Instagram feed!** 🚀

---

## 📞 Need Help?

Common issues usually are:
1. Instagram account type (needs Business/Creator)
2. Facebook Page connection (required for Graph API)
3. Token expiration (refresh every 60 days)

Check these three things and most issues resolve!
