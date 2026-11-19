# Facebook Pixel Events Documentation

## Overview
This document outlines all Facebook Pixel tracking events implemented on The Beauty Hive website.

**Pixel ID:** 809511211491558

---

## Standard Events Implemented

### 1. 🔵 PageView (Automatic)
**Triggers:** Every time any page loads
**Location:** All pages (`<head>` section)

```javascript
fbq('track', 'PageView');
```

**Pages tracked:**
- ✅ Homepage (`/`)
- ✅ Privacy Policy (`/privacy-policy`)
- ✅ Data Deletion (`/data-deletion`)

---

### 2. 👁️ ViewContent
**Triggers:** When a user clicks on a service portfolio button
**Location:** `index.html` - Portfolio section

**Parameters:**
- `content_name`: The service name (e.g., "Gel-X Sets", "Acrylic Sets", "Builder Gel Sets", "Pedicures")
- `content_category`: "Nail Services"
- `content_type`: "service"

```javascript
fbq('track', 'ViewContent', {
    content_name: serviceName,
    content_category: 'Nail Services',
    content_type: 'service'
});
```

**What it tracks:**
- ✅ When user clicks "Gel-X Sets" button → `content_name: "Gel-X Sets"`
- ✅ When user clicks "Acrylic Sets" button → `content_name: "Acrylic Sets"`
- ✅ When user clicks "Builder Gel Sets" button → `content_name: "Builder Gel Sets"`
- ✅ When user clicks "Pedicures" button → `content_name: "Pedicures"`

**Use case:** Track which services are most popular/interesting to visitors

---

### 3. 📅 Schedule
**Triggers:** When a user clicks any "BOOK NOW" button
**Location:** Multiple locations on homepage

```javascript
fbq('track', 'Schedule');
```

**Buttons tracked:**
- ✅ "BOOK NOW" button under nail tech photo
- ✅ "BOOK NOW" button after portfolio section (desktop only)
- ✅ Sticky "BOOK NOW" footer button (mobile only)

**Use case:** Track booking intent and optimize for appointment conversions

---

### 4. 🛒 InitiateCheckout
**Triggers:** When a user interacts with the Acuity booking calendar
**Location:** Acuity Scheduling section

**Three tracking points:**

#### A. Booking Section Viewed
When user scrolls to booking section (30% visible):
```javascript
fbq('track', 'InitiateCheckout', {
    content_name: 'Booking Form Viewed',
    content_category: 'Nail Services',
    content_type: 'booking_form'
});
```

#### B. Booking Form Interaction
When user clicks into the Acuity iframe:
```javascript
fbq('track', 'InitiateCheckout', {
    content_name: 'Booking Form Interaction',
    content_category: 'Nail Services',
    content_type: 'booking_form_click'
});
```

#### C. Service Selected (if Acuity sends data)
When user selects a specific service in calendar:
```javascript
fbq('track', 'InitiateCheckout', {
    content_name: 'Gel-X Sets', // Service name from Acuity
    content_category: 'Nail Services',
    content_type: 'service_selected',
    value: 65.00,
    currency: 'USD'
});
```

**Use case:** Track the booking funnel from viewing to selecting services

---

### 5. 🎯 Lead
**Triggers:** When a user completes a booking (if Acuity sends confirmation)
**Location:** Acuity Scheduling iframe

```javascript
fbq('track', 'Lead', {
    content_name: 'Gel-X Sets',
    content_category: 'Nail Services',
    value: 65.00,
    currency: 'USD'
});
```

**Use case:** Track completed bookings and calculate conversion value

---

## Viewing Events in Facebook

### Method 1: Events Manager
1. Go to [Facebook Events Manager](https://business.facebook.com/events_manager2)
2. Select Pixel ID: **809511211491558**
3. Click "Test Events" to see real-time events
4. Click "Activity" to see event history

### Method 2: Facebook Pixel Helper (Chrome Extension)
1. Install [Facebook Pixel Helper](https://chrome.google.com/webstore/detail/facebook-pixel-helper/fdgfkebogiimcoedlicjlajpkdmockpc)
2. Visit your website
3. Click the extension icon to see events firing

### Method 3: Browser Developer Console
1. Open DevTools (F12)
2. Go to Console tab
3. Look for Facebook Pixel messages
4. Or check Network tab for `fbevents.js` requests

---

## Event Data Examples

### PageView Event
```json
{
  "event": "PageView",
  "timestamp": "2025-10-07T12:00:00Z",
  "url": "https://yourdomain.com/"
}
```

### ViewContent Event - Gel-X Sets
```json
{
  "event": "ViewContent",
  "content_name": "Gel-X Sets",
  "content_category": "Nail Services",
  "content_type": "service",
  "timestamp": "2025-10-07T12:05:30Z"
}
```

### Schedule Event
```json
{
  "event": "Schedule",
  "timestamp": "2025-10-07T12:10:00Z"
}
```

---

## Using Events in Facebook Ads

### 1. Create Custom Audiences
Target people who:
- Viewed specific services (e.g., only people who clicked "Gel-X Sets")
- Clicked "Book Now" but didn't complete booking
- Visited your site multiple times

### 2. Create Custom Conversions
Set up conversions for:
- **Service Interest**: ViewContent event = someone interested in services
- **Booking Intent**: Schedule event = high intent to book
- **Completed Booking**: When someone reaches the booking confirmation (requires additional setup)

### 3. Optimize Ad Delivery
Use events to optimize your ads:
- **Awareness Campaigns**: Optimize for PageView
- **Consideration Campaigns**: Optimize for ViewContent
- **Conversion Campaigns**: Optimize for Schedule

---

## Testing Your Events

### Test Checklist:

#### ✅ PageView Event
1. Visit homepage → Check Events Manager for PageView
2. Visit privacy policy → Check for PageView
3. Visit data deletion → Check for PageView

#### ✅ ViewContent Event
1. Click "Gel-X Sets" button → Check for ViewContent with `content_name: "Gel-X Sets"`
2. Click "Acrylic Sets" button → Check for ViewContent with `content_name: "Acrylic Sets"`
3. Click "Builder Gel Sets" button → Check for ViewContent with `content_name: "Builder Gel Sets"`
4. Click "Pedicures" button → Check for ViewContent with `content_name: "Pedicures"`

#### ✅ Schedule Event
1. Click any "BOOK NOW" button → Check for Schedule event
2. Try mobile view and click sticky footer button → Check for Schedule event

---

## Advanced Tracking (Future Enhancements)

### Recommended Additional Events:

#### 1. **Contact Event**
Track when users click social media links or phone number:
```javascript
fbq('track', 'Contact');
```

#### 2. **Lead Event**
Track when booking form is submitted:
```javascript
fbq('track', 'Lead');
```

#### 3. **Custom Events**
Track specific interactions:
```javascript
fbq('trackCustom', 'ViewInstagramPost');
fbq('trackCustom', 'NavigationClick', {section: 'FAQ'});
```

#### 4. **Value Tracking**
Add value to service views:
```javascript
fbq('track', 'ViewContent', {
    content_name: serviceName,
    content_category: 'Nail Services',
    content_type: 'service',
    value: 50.00,  // Average service value
    currency: 'USD'
});
```

---

## Troubleshooting

### Event not firing?

**Check these:**
1. ✅ Facebook Pixel code is in `<head>` section
2. ✅ Code is deployed to production
3. ✅ Clear browser cache and test in incognito mode
4. ✅ Check browser console for JavaScript errors
5. ✅ Verify Pixel ID is correct: **809511211491558**

### Event firing but not showing in Events Manager?

**Possible causes:**
1. **Delay** - Events can take 5-20 minutes to appear
2. **Ad Blockers** - Disable ad blockers when testing
3. **Browser Privacy Settings** - Try a different browser
4. **Filter Settings** - Check date range and filters in Events Manager

### Parameters not passing correctly?

**Debug steps:**
1. Open browser console (F12)
2. Add this code to console:
```javascript
// Log all FB pixel events
fbq('track', 'PageView', {}, {eventID: 'test'});
console.log('FB Pixel loaded:', typeof fbq !== 'undefined');
```

---

## Privacy & Compliance

✅ **Privacy Policy Updated**: Facebook Pixel usage is disclosed
✅ **Data Deletion Page**: Instructions provided
✅ **GDPR/CCPA**: Consider adding a cookie consent banner for EU/CA visitors

---

## Performance Impact

**Impact on page load:** Minimal
- Pixel loads asynchronously
- Does not block page rendering
- File size: ~30KB

**Best practices:**
- ✅ Already in `<head>` for early loading
- ✅ Using async loading
- ✅ Events fire after user interaction (no performance impact)

---

## Summary

**Total Events Implemented:** 5 Standard Events

| Event | Type | Trigger | Parameters |
|-------|------|---------|------------|
| PageView | Automatic | All pages load | None |
| ViewContent | User Action | Service portfolio button click | content_name, content_category, content_type |
| Schedule | User Action | Book Now button click | None |
| InitiateCheckout | User Action | Booking form viewed/clicked | content_name, content_category, content_type |
| Lead | User Action | Booking completed (Acuity) | content_name, content_category, value, currency |

**Next Steps:**
1. Deploy to production
2. Test all events in Facebook Events Manager
3. Create custom audiences based on events
4. Set up conversion tracking in Facebook Ads
5. Monitor event performance and optimize

---

**Last Updated:** October 7, 2025
**Pixel ID:** 809511211491558
**Status:** Active ✅
**Events:** Configured & Ready to Deploy 🚀
