# Facebook Pixel Setup Documentation

## Overview
The Facebook Pixel (ID: **809511211491558**) has been installed on all pages of The Beauty Hive website to track visitor activity and conversions.

## Current Installation Status ✅

The Facebook Pixel script has been successfully added to:
- ✅ `public/index.html` - Main homepage
- ✅ `public/data-deletion.html` - Data deletion page
- ✅ `public/privacy-policy.html` - Privacy policy page

## Pixel Code Location
The pixel code is placed in the `<head>` section of each HTML file, immediately after the `<title>` tag. This ensures early loading and proper tracking.

## For Future Pages
When creating new HTML pages, follow these steps to ensure the Facebook Pixel is included:

### Option 1: Use the Template (Recommended)
1. Copy the `NEW_PAGE_TEMPLATE.html` file from the project root
2. Rename it to your new page name (e.g., `new-page.html`)
3. Update the page title and content
4. The Facebook Pixel is already included in the template!

### Option 2: Manual Addition
If creating a page from scratch, add this code in the `<head>` section after the `<title>` tag:

```html
<!-- Meta Pixel Code -->
<script>
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window, document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', '809511211491558');
fbq('track', 'PageView');
</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=809511211491558&ev=PageView&noscript=1"
/></noscript>
<!-- End Meta Pixel Code -->
```

## What the Pixel Tracks

The Facebook Pixel automatically tracks:
- **PageView** - Every time a page loads
- Visitor behavior and navigation patterns
- Traffic sources
- Conversion events (if configured in Facebook Ads Manager)

## Verifying the Pixel

### Method 1: Facebook Pixel Helper (Chrome Extension)
1. Install the [Facebook Pixel Helper](https://chrome.google.com/webstore/detail/facebook-pixel-helper/fdgfkebogiimcoedlicjlajpkdmockpc)
2. Visit your website
3. Click the extension icon - it should show the pixel is active

### Method 2: Facebook Events Manager
1. Go to [Facebook Events Manager](https://business.facebook.com/events_manager2)
2. Select your pixel (809511211491558)
3. View the "Activity" section to see recent page views

### Method 3: Browser Developer Tools
1. Open your website
2. Open browser DevTools (F12)
3. Go to Network tab
4. Filter for "fbevents"
5. You should see requests to `facebook.net/en_US/fbevents.js`

## Advanced Tracking (Optional)

To track custom events like bookings or button clicks, add code like this:

```javascript
// Track when someone clicks "Book Now"
fbq('track', 'Schedule');

// Track when someone views contact info
fbq('track', 'Contact');

// Track custom conversions
fbq('trackCustom', 'BookingStarted');
```

## Privacy Considerations

✅ **Privacy Policy Updated**: The Facebook Pixel has been disclosed in the privacy policy and data deletion pages.

## Support

If you need to:
- Change the Pixel ID
- Add custom tracking events
- Configure conversions in Facebook Ads Manager
- Troubleshoot tracking issues

Refer to [Facebook's Business Help Center](https://www.facebook.com/business/help/952192354843755) or contact your Facebook Ads account manager.

## Maintenance Checklist

When adding new pages to the site:
- [ ] Include the Facebook Pixel code in the `<head>` section
- [ ] Test with Facebook Pixel Helper
- [ ] Verify page view events in Facebook Events Manager
- [ ] Update this documentation with the new page name

---

**Last Updated**: October 7, 2025
**Pixel ID**: 809511211491558
**Status**: Active ✅
