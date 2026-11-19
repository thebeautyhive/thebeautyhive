# Facebook Pixel Custom Events Guide

## Overview
This guide explains the custom events implemented on The Beauty Hive website, in addition to the standard Facebook Pixel events.

**Pixel ID:** 809511211491558

---

## 🎯 Custom Events vs Standard Events

### Standard Events
Standard events are predefined by Facebook and have special optimization features:
- `PageView` - Page loads
- `ViewContent` - Viewing content
- `InitiateCheckout` - Starting checkout/booking process
- `Schedule` - **Completing** an appointment booking
- `Lead` - Capturing a lead/conversion

### Custom Events
Custom events are events you define yourself for tracking specific actions unique to your business:
```javascript
fbq('trackCustom', 'EventName', {
    parameter1: 'value1',
    parameter2: 'value2'
});
```

---

## 📊 Custom Event: BookNowClick

**Purpose:** Track when users click "Book Now" buttons (intent to book, not completion)

**Why Custom?** The standard `Schedule` event should only fire when an appointment is **actually booked**, not just when someone clicks a button. So we created a custom event for button clicks.

### Implementation

```javascript
fbq('trackCustom', 'BookNowClick', {
    button_location: 'hero_section'
});
```

### Tracking Points

| Button Location | Parameter Value | Description |
|----------------|-----------------|-------------|
| Hero Section (under photo) | `hero_section` | Main CTA button |
| After Portfolio | `after_portfolio` | Desktop button after gallery |
| Sticky Footer | `sticky_footer` | Mobile sticky footer button |
| About Section | `about_section` | Button in about section |

### Code Examples

**Hero Section:**
```html
<a href="#booking"
   onclick="if(typeof fbq !== 'undefined') fbq('trackCustom', 'BookNowClick', {button_location: 'hero_section'});">
   BOOK APPOINTMENT
</a>
```

**After Portfolio (Desktop):**
```html
<a href="#booking"
   onclick="if(typeof fbq !== 'undefined') fbq('trackCustom', 'BookNowClick', {button_location: 'after_portfolio'});">
   BOOK NOW
</a>
```

**Sticky Footer (Mobile):**
```html
<a href="#booking"
   onclick="if(typeof fbq !== 'undefined') fbq('trackCustom', 'BookNowClick', {button_location: 'sticky_footer'});">
   BOOK NOW
</a>
```

---

## 📈 Complete Event Tracking Flow

Here's the full customer journey with all events:

```
1. User lands on site
   └─→ PageView (standard)

2. User clicks service portfolio button (e.g., "Gel-X Sets")
   └─→ ViewContent (standard)
       Parameters: content_name="Gel-X Sets"

3. User clicks "Book Now" button
   └─→ BookNowClick (CUSTOM)
       Parameters: button_location="hero_section"

4. User scrolls to booking section
   └─→ InitiateCheckout (standard)
       Parameters: content_name="Booking Form Viewed"

5. User clicks into Acuity calendar
   └─→ InitiateCheckout (standard)
       Parameters: content_name="Booking Form Interaction"

6. User selects service in Acuity (if data available)
   └─→ InitiateCheckout (standard)
       Parameters: content_name="Gel-X Sets", value=65.00

7. User completes booking
   └─→ Schedule (standard) ← THE ACTUAL BOOKING
       Parameters: content_name="Gel-X Sets", value=65.00
   └─→ Lead (standard) ← CONVERSION
       Parameters: content_name="Gel-X Sets", value=65.00
```

---

## 🎯 Why This Approach?

### Problem:
- `Schedule` is a **standard event** for completed appointments
- Clicking "Book Now" is **not** a completed appointment (it's just intent)
- We need to track button clicks separately from actual bookings

### Solution:
- **Custom Event (`BookNowClick`)** = User clicks button (high intent)
- **Standard Event (`Schedule`)** = User completes booking (conversion)

### Benefits:
1. ✅ Proper event semantics (Schedule = actual booking)
2. ✅ Track which buttons drive the most engagement
3. ✅ Create audiences for people who clicked but didn't book (retargeting!)
4. ✅ Optimize Facebook ads for actual bookings, not just clicks

---

## 📊 Viewing Custom Events in Facebook

### Events Manager
1. Go to [Facebook Events Manager](https://business.facebook.com/events_manager2)
2. Select your pixel (809511211491558)
3. Custom events appear alongside standard events
4. Look for **"BookNowClick"** in the events list

### Test Events
1. Click "Test Events" in Events Manager
2. Enter your website URL
3. Open your site and click "Book Now"
4. You'll see: `Custom Event: BookNowClick`

---

## 🎯 Using Custom Events in Facebook Ads

### 1. Create Custom Audiences

**High-Intent Visitors:**
- People who viewed content (`ViewContent`)
- AND clicked Book Now (`BookNowClick`)
- BUT didn't complete booking (`Schedule`)
- = Perfect retargeting audience!

**Button Performance:**
Track which buttons convert best:
- `button_location = 'hero_section'`
- `button_location = 'after_portfolio'`
- `button_location = 'sticky_footer'`

### 2. Create Custom Conversions

You can create a custom conversion in Facebook Ads Manager:
1. Go to Events Manager → Custom Conversions
2. Click "Create Custom Conversion"
3. Name: "Book Now Button Click"
4. Event: `BookNowClick`
5. Use for ad optimization!

### 3. Optimize Campaigns

**Awareness Campaign:**
- Optimize for: `PageView`
- Goal: Get visitors to your site

**Consideration Campaign:**
- Optimize for: `BookNowClick`
- Goal: Get people to show booking intent

**Conversion Campaign:**
- Optimize for: `Schedule`
- Goal: Get actual bookings

---

## 🧪 Testing Custom Events

### Browser Console Test:

1. Open your site
2. Open Console (F12)
3. Click a "Book Now" button
4. You should see:
```
(No console log for BookNowClick - it's inline)
```
5. Check Facebook Pixel Helper extension - should show:
```
Custom Event: BookNowClick
Parameters:
  button_location: "hero_section"
```

### Facebook Test Events:

1. Open Test Events in Events Manager
2. Click any "Book Now" button on your site
3. Should appear as:
```
Custom Event
BookNowClick
  button_location: hero_section
```

---

## 📋 Event Summary

| Event Type | Event Name | Trigger | When It Fires |
|-----------|------------|---------|---------------|
| Standard | PageView | Page load | Every page |
| Standard | ViewContent | Service click | Portfolio buttons |
| **Custom** | **BookNowClick** | **Button click** | **Any "Book Now" button** |
| Standard | InitiateCheckout | Booking interaction | Acuity form viewed/clicked |
| Standard | Schedule | **Booking completed** | **Acuity confirmation** |
| Standard | Lead | Conversion | Acuity confirmation |

---

## 💡 Best Practices

### DO:
✅ Use custom events for business-specific actions
✅ Use descriptive names (e.g., `BookNowClick` not `Click1`)
✅ Pass helpful parameters (e.g., `button_location`)
✅ Reserve standard events for their intended purpose

### DON'T:
❌ Use `Schedule` for button clicks
❌ Use generic names like `CustomEvent1`
❌ Track the same action with multiple events
❌ Forget to add parameters for segmentation

---

## 🔧 Adding More Custom Events

To add new custom events, use this format:

```javascript
fbq('trackCustom', 'YourEventName', {
    parameter1: 'value1',
    parameter2: 'value2'
});
```

**Example - Track Service Inquiry:**
```javascript
fbq('trackCustom', 'ServiceInquiry', {
    service_type: 'Gel-X Sets',
    inquiry_method: 'instagram_dm'
});
```

**Example - Track Gallery Image Click:**
```javascript
fbq('trackCustom', 'GalleryImageClick', {
    service_category: 'Acrylic Sets',
    image_number: 3
});
```

---

## 📊 Reporting & Analysis

### Key Questions You Can Answer:

1. **Button Performance:**
   - Which "Book Now" button gets clicked most?
   - Query: Count of `BookNowClick` by `button_location`

2. **Conversion Rate:**
   - How many button clicks lead to bookings?
   - Calculation: `Schedule` events / `BookNowClick` events

3. **Drop-off Points:**
   - Where do people abandon the booking flow?
   - Track: BookNowClick → InitiateCheckout → Schedule

---

## 🎓 Learning Resources

- [Facebook Custom Events Documentation](https://developers.facebook.com/docs/meta-pixel/reference#custom-events)
- [Standard Events vs Custom Events](https://www.facebook.com/business/help/402791146561655)
- [Custom Conversions Guide](https://www.facebook.com/business/help/1151869044899148)

---

**Last Updated:** October 7, 2025
**Pixel ID:** 809511211491558
**Custom Events:** 1 (BookNowClick)
**Standard Events:** 5 (PageView, ViewContent, InitiateCheckout, Schedule, Lead)
