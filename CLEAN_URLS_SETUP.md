# Clean URLs Setup Guide

This guide explains how to remove the `.html` extension from your URLs (e.g., `/privacy-policy` instead of `/privacy-policy.html`).

## ✅ What's Been Done

All internal links have been updated to use clean URLs:
- `/privacy-policy` instead of `/privacy-policy.html`
- `/data-deletion` instead of `/data-deletion.html`
- `/` for homepage instead of `/index.html`

Configuration files have been created for multiple hosting platforms.

## 🚀 Setup Instructions by Hosting Platform

### Option 1: Netlify (Recommended for Static Sites)

**Already configured!** Just deploy to Netlify and it will work automatically.

Files that make it work:
- ✅ `public/_redirects`
- ✅ `netlify.toml`

To deploy:
1. Sign up at [netlify.com](https://netlify.com)
2. Connect your Git repository OR drag & drop the `public` folder
3. Clean URLs will work automatically!

**Deployment settings:**
- Build command: (leave empty for static site)
- Publish directory: `public`

---

### Option 2: Vercel

**Already configured!** Just deploy to Vercel and it will work automatically.

File that makes it work:
- ✅ `vercel.json`

To deploy:
1. Sign up at [vercel.com](https://vercel.com)
2. Import your Git repository
3. Deploy!

**Deployment settings:**
- Framework Preset: Other
- Build Command: (leave empty)
- Output Directory: `public`

---

### Option 3: GitHub Pages

For GitHub Pages, you'll need to use a Jekyll workaround:

1. Create a file named `.nojekyll` in the `public` folder:
   ```bash
   touch public/.nojekyll
   ```

2. Add this to your repository settings:
   - Go to Settings → Pages
   - Set source to main branch → /public folder

3. **Note:** GitHub Pages has limited clean URL support. Consider using Netlify or Vercel instead.

---

### Option 4: Apache Server (cPanel, shared hosting, etc.)

**Already configured!** The `.htaccess` file is ready.

File that makes it work:
- ✅ `public/.htaccess`

Steps:
1. Upload all files from the `public` folder to your web server
2. Make sure the `.htaccess` file is uploaded (it might be hidden)
3. Ensure Apache's `mod_rewrite` is enabled (most hosts have this by default)

To verify:
```bash
# If you have SSH access, check if mod_rewrite is enabled
apache2ctl -M | grep rewrite
```

---

### Option 5: Nginx Server

If using Nginx, add this to your server configuration:

```nginx
server {
    listen 80;
    server_name yourdomain.com;
    root /path/to/public;
    index index.html;

    # Remove .html extension
    location / {
        try_files $uri $uri.html $uri/ =404;
    }

    # Redirect .html URLs to clean URLs
    if ($request_uri ~ ^/(.*)\.html$) {
        return 301 /$1;
    }
}
```

Then reload Nginx:
```bash
sudo systemctl reload nginx
```

---

## 🧪 Testing Clean URLs

After deploying, test these URLs (replace with your domain):

✅ Should work:
- `https://yourdomain.com/`
- `https://yourdomain.com/privacy-policy`
- `https://yourdomain.com/data-deletion`

🔄 Should redirect to clean URLs:
- `https://yourdomain.com/privacy-policy.html` → redirects to `/privacy-policy`
- `https://yourdomain.com/data-deletion.html` → redirects to `/data-deletion`

---

## 🔍 Troubleshooting

### URLs still show .html extension:

**Possible causes:**
1. **Wrong hosting platform configuration** - Make sure you're using the right config file for your host
2. **Caching** - Clear your browser cache or try in incognito mode
3. **Server not supporting rewrites** - Some basic hosts don't support URL rewriting

**Solutions:**
- Try deploying to Netlify (easiest option, free tier available)
- Check if your server has mod_rewrite enabled (Apache)
- Clear browser cache and test in incognito mode

### 404 errors on clean URLs:

**Possible causes:**
1. Configuration file not being read
2. Files uploaded to wrong directory
3. Server doesn't support the configuration method

**Solutions:**
1. **For Apache:** Make sure `.htaccess` is in the same directory as your HTML files
2. **For Netlify/Vercel:** Make sure config files are in the root directory
3. Try a different hosting platform

---

## 📝 Current Footer Links

The footer now shows only the Privacy Policy link:
- ✅ Homepage: Shows "Privacy Policy" link
- ✅ Privacy Policy page: Shows "← Back to Home" link
- ✅ Data Deletion page: Shows "View Privacy Policy" and "Back to Home" links

All links use clean URLs (no `.html` extension).

---

## 🌟 Recommended Hosting Platform

**We recommend Netlify** for the following reasons:
- ✅ Free tier available
- ✅ Clean URLs work automatically
- ✅ Automatic HTTPS/SSL
- ✅ CDN included
- ✅ Easy deployment (drag & drop or Git integration)
- ✅ Custom domain support
- ✅ Instant cache invalidation

## Quick Deploy to Netlify

1. Go to [netlify.com](https://netlify.com) and sign up
2. Drag and drop the `public` folder
3. Done! Your site is live with clean URLs

---

**Last Updated:** October 7, 2025
**Status:** Configuration files created ✅
