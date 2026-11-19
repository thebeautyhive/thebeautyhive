# How to Switch from Elfsight to Custom Widget

## 🎯 WHY SWITCH?

Elfsight wants you to **pay $10-160/month** for features like:
- Remove branding badge ❌ (PAID)
- Grid/Masonry/List layouts ❌ (LIMITED on free)
- Load More button ❌ (LIMITED on free)
- Custom styling ❌ (PAID)

**Your custom widget has ALL OF THIS FOR FREE!** ✅

## 📋 Current Status

✅ **Elfsight widget is active** (using now - has branding)
✅ **Custom widget is ready** (saved in `CUSTOM_WIDGET_BACKUP.html`)
✅ **Privacy pages created** (ready for Facebook)
⏳ **Waiting for Facebook app approval**

---

## 🔄 When to Switch

Switch to the custom widget when:
1. ✅ Your Facebook app is approved
2. ✅ You have your Instagram Access Token
3. ✅ You're ready to save money ($0 vs $10+/month)

---

## ⚡ Quick Switch Guide (5 minutes)

### Step 1: Remove Elfsight (2 lines)

In `public/index.html` around **line 578-580**, **DELETE** these lines:

```html
<!-- DELETE THIS: -->
<script src="https://elfsightcdn.com/platform.js" async></script>
<div class="elfsight-app-d6a6f61d-36b9-4fcc-b0cb-2cdae99d23d3" data-elfsight-app-lazy></div>
```

### Step 2: Uncomment Custom Widget

Find this line around **595**:
```html
<!-- Custom Instagram Feed Widget (DISABLED FOR NOW) -->
<!-- <div class="mt-8 max-w-6xl mx-auto px-4">
```

**Remove the `<!--` at the start**

Then find around line **678**:
```html
            </div> -->
            <!-- END CUSTOM INSTAGRAM FEED -->
```

**Remove the `-->` at the end**

### Step 3: Uncomment Modal

Find around line **683**:
```html
<!-- <div id="insta-modal" class="modal">
```

**Remove `<!--` at start and `-->` at end** (around line 689)

### Step 4: Activate JavaScript

Find around line **856**:
```javascript
// Initialize Instagram Feed (DISABLED - uncomment when ready)
// initInstagramFeed();
```

**Remove the `//` to uncomment**:
```javascript
// Initialize Instagram Feed
initInstagramFeed();
```

### Step 5: Add Your Access Token

Find around line **866**:
```javascript
const INSTAGRAM_CONFIG = {
    accessToken: '', // ADD YOUR ACCESS TOKEN HERE
```

**Paste your token**:
```javascript
const INSTAGRAM_CONFIG = {
    accessToken: 'YOUR_LONG_TOKEN_HERE',
```

### Step 6: Test!

1. Save the file
2. Refresh your website
3. Open browser console (F12)
4. Look for: `✅ Successfully fetched X posts from Instagram`
5. Your real Instagram posts should appear!

---

## 🎯 Simple Copy-Paste Method

If you prefer, here's what to search and replace:

### Search for:
```html
<!-- Elfsight Social Feed Integration -->
<script src="https://elfsightcdn.com/platform.js" async></script>
<div class="elfsight-app-d6a6f61d-36b9-4fcc-b0cb-2cdae99d23d3" data-elfsight-app-lazy></div>
```

### Replace with:
```html
<!-- Elfsight Removed - Using Custom Widget -->
```

Then uncomment the custom widget sections as described above.

---

## 📍 Exact Line Numbers Reference

| Action | Line(s) | What to Do |
|--------|---------|------------|
| Delete Elfsight | 578-580 | Remove 2 lines completely |
| Uncomment widget start | 595 | Remove `<!--` |
| Uncomment widget end | 678 | Remove `-->` |
| Uncomment modal start | 683 | Remove `<!--` |
| Uncomment modal end | 689 | Remove `-->` |
| Uncomment JS init | 856 | Remove `//` |
| Add token | 866 | Paste between quotes |

---

## ✅ Verification Checklist

After switching, verify:

- [ ] Elfsight script removed
- [ ] Custom widget uncommented
- [ ] Modal uncommented
- [ ] JavaScript init uncommented
- [ ] Access token added
- [ ] Page loads without errors
- [ ] Instagram posts display
- [ ] Console shows success message
- [ ] Click post opens modal
- [ ] View switchers work (Grid/Masonry/List)
- [ ] Load More works

---

## 🐛 Troubleshooting

### "Nothing displays"
- Check if you uncommented all sections
- Verify access token is added
- Check browser console for errors

### "Using manual posts"
- Access token not added or invalid
- Check console for error messages
- Verify token is between the quotes

### "Instagram API error"
- Token may be expired (refresh it)
- App may not be approved yet
- Check Facebook app status

### "Layout looks broken"
- Make sure you didn't delete CSS
- Clear browser cache (Ctrl+Shift+R)
- Check for missing closing tags

---

## 💰 Benefits After Switching

| Feature | Elfsight | Custom Widget |
|---------|----------|---------------|
| Monthly Cost | $10-160 | **$0** |
| View Limits | 200-Unlimited | **Unlimited** |
| Customization | Limited | **Full Control** |
| Branding | May have branding | **None** |
| Dependencies | External service | **Self-hosted** |
| Loading Speed | Slower | **Faster** |
| View Modes | 1 | **3 (Grid/Masonry/List)** |
| Privacy | Their terms | **Your control** |

---

## 📞 Need Help?

If you run into issues:
1. Check `INSTAGRAM_API_SETUP.md` for token help
2. Check `QUICK_START.md` for testing tips
3. Review browser console for error messages
4. Verify all comment tags are properly removed

---

## 🎉 You're Ready!

Everything is set up and ready. When your Facebook app is approved:
1. Get your access token
2. Follow the steps above
3. Switch in 5 minutes
4. Never pay for Instagram feed again!

**Your custom widget is waiting to save you money!** 💰
