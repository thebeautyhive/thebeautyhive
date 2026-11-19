# Debugging Facebook Pixel Events

## Issue: ViewContent Event Not Firing

If you're seeing **Schedule** events but not **ViewContent** events, follow these steps to debug:

---

## 🔍 Step 1: Check Browser Console (IMPORTANT!)

The latest version has debug logging enabled. Here's what to do:

1. **Open your website** in Chrome/Firefox
2. **Right-click anywhere** → Select "Inspect" or press `F12`
3. **Click the "Console" tab** at the top
4. **Click one of the service buttons** (e.g., "Gel-X Sets")

### What You Should See:

```
Service clicked: Gel-X Sets
Facebook Pixel available: true
Firing ViewContent event for: Gel-X Sets
```

### What It Means:

#### ✅ If you see all three messages:
- The event IS firing correctly!
- Check Facebook Events Manager (see Step 3 below)
- May need to wait 5-20 minutes for events to show up

#### ⚠️ If you see "Facebook Pixel available: false":
- The Facebook Pixel script hasn't loaded yet
- Try these fixes:
  - **Disable ad blockers** (they block Facebook Pixel!)
  - **Try incognito/private mode**
  - **Clear browser cache** and refresh
  - **Check if you have tracking protection enabled** in browser settings

#### ❌ If you see nothing at all:
- JavaScript error preventing the function from running
- Check for **red error messages** in the console
- Send me a screenshot of the console

---

## 🛡️ Step 2: Check for Ad Blockers / Tracking Protection

**Most common issue!** Ad blockers prevent Facebook Pixel from loading.

### Disable These:
- ❌ AdBlock / AdBlock Plus
- ❌ uBlock Origin
- ❌ Privacy Badger
- ❌ Brave Shields
- ❌ Firefox Enhanced Tracking Protection (strict mode)

### How to Test:
1. Open your site in **Incognito/Private mode** (ad blockers usually disabled)
2. Or temporarily disable your ad blocker
3. Try clicking service buttons again
4. Check browser console for the debug messages

---

## 📊 Step 3: Check Facebook Events Manager

Even if events are firing, they may take time to appear:

1. Go to [Facebook Events Manager](https://business.facebook.com/events_manager2/list/pixel/809511211491558)
2. Click **"Test Events"** in the left menu
3. Enter your website URL (without https://)
4. In a new tab, open your website
5. Click service buttons
6. Watch for events appearing in Events Manager (usually 1-5 seconds)

### What You Should See in Test Events:

```
🔵 PageView
   URL: https://yourdomain.com/

👁️ ViewContent
   content_name: "Gel-X Sets"
   content_category: "Nail Services"
   content_type: "service"
```

---

## 🧪 Step 4: Use Facebook Pixel Helper

Install the official Chrome extension:

1. Install: [Facebook Pixel Helper](https://chrome.google.com/webstore/detail/facebook-pixel-helper/fdgfkebogiimcoedlicjlajpkdmockpc)
2. Open your website
3. Click the extension icon (should show a badge with "1" or "2")
4. Click a service button
5. Check the extension - should show ViewContent event

### What It Shows:

```
✅ Facebook Pixel (809511211491558)

Events:
- PageView (on page load)
- ViewContent (when you click service button)
```

---

## 🕐 Step 5: Check Timing

### Deployment
- **Wait 2-3 minutes** after pushing for Vercel to deploy
- Check Vercel dashboard for deployment status
- Make sure the deployment succeeded

### Event Reporting
- Events appear in **Test Events** almost instantly
- Events appear in **Activity/Analytics** in 5-20 minutes
- Historical reports can take up to 2 hours

---

## 🔧 Common Issues & Fixes

### Issue: "Schedule works, but ViewContent doesn't"

**Why this happens:**
- Schedule event is on an HTML element (`<a href="..." onclick="...">`)
- ViewContent is in a JavaScript function that's dynamically loaded
- May be a timing or scope issue

**Fix:**
Check browser console when clicking services - you should see the debug messages.

---

### Issue: Ad Blocker Blocking Pixel

**Symptoms:**
- Console shows: `Facebook Pixel available: false`
- No Facebook network requests in Network tab
- Facebook Pixel Helper shows nothing

**Fix:**
1. Disable ad blocker
2. Use incognito mode
3. Use a different browser
4. Whitelist your domain in ad blocker settings

---

### Issue: Events Don't Show in Facebook

**Possible causes:**
1. **Not waiting long enough** - Wait 5-20 minutes
2. **Wrong date range filter** - Check date filters in Events Manager
3. **Testing in dev mode** - Make sure you're on production URL
4. **Events blocked** - Check browser console for errors

**Fix:**
- Use "Test Events" feature (shows real-time)
- Check "Last 7 Days" filter
- Verify pixel ID matches: **809511211491558**

---

## ✅ Quick Verification Checklist

Test this sequence:

1. [ ] Open website in incognito mode (no ad blockers)
2. [ ] Open browser console (F12 → Console tab)
3. [ ] You should see: `PageView` tracking firing
4. [ ] Click "Gel-X Sets" button
5. [ ] Console should show: "Service clicked: Gel-X Sets"
6. [ ] Console should show: "Firing ViewContent event for: Gel-X Sets"
7. [ ] Open Facebook Events Manager Test Events
8. [ ] You should see ViewContent event appear

---

## 📸 Share This With Me

If still not working, send me:

1. **Screenshot of browser console** when you click a service button
2. **Browser you're using** (Chrome, Firefox, Safari, etc.)
3. **Any ad blockers installed**
4. **Screenshot of Facebook Events Manager** (Test Events tab)

---

## 🎯 Expected Behavior

### When clicking "Gel-X Sets":
```javascript
// Console output:
Service clicked: Gel-X Sets
Facebook Pixel available: true
Firing ViewContent event for: Gel-X Sets

// Facebook receives:
Event: ViewContent
Parameters: {
  content_name: "Gel-X Sets",
  content_category: "Nail Services",
  content_type: "service"
}
```

### When clicking "Book Now":
```javascript
// Console output: (none for Book Now - it's inline)

// Facebook receives:
Event: Schedule
Parameters: (none)
```

---

## 🆘 Still Not Working?

If you've tried everything above and ViewContent still isn't firing:

1. **Check Console** - Look for JavaScript errors (red text)
2. **Verify Deployment** - Make sure latest code is deployed
3. **Try Different Browser** - Test in Chrome incognito
4. **Contact Me** - Share console screenshots

---

**Last Updated:** October 7, 2025
**Status:** Debug logging enabled ✅
**Deployed:** Vercel auto-deploying now 🚀
