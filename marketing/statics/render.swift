import CoreGraphics
import CoreText
import Foundation
import ImageIO
import UniformTypeIdentifiers

struct RGBA {
    let r: CGFloat
    let g: CGFloat
    let b: CGFloat
    let a: CGFloat

    init(_ hex: Int, alpha: CGFloat = 1) {
        self.r = CGFloat((hex >> 16) & 0xff) / 255
        self.g = CGFloat((hex >> 8) & 0xff) / 255
        self.b = CGFloat(hex & 0xff) / 255
        self.a = alpha
    }

    func cgColor() -> CGColor {
        CGColor(red: r, green: g, blue: b, alpha: a)
    }
}

struct Concept {
    let slug: String
    let imagePath: String
    let kicker: String
    let headline: String
    let subhead: String
    let cta: String
    let tint: RGBA
}

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let exportDir = root.appendingPathComponent("marketing/statics/exports", isDirectory: true)
try FileManager.default.createDirectory(at: exportDir, withIntermediateDirectories: true)

let concepts = [
    Concept(
        slug: "first-set",
        imagePath: "public/images/nails-summer-cherry-art.jpg",
        kicker: "New-client set",
        headline: "Bring the inspo you have been saving.",
        subhead: "Custom nails with Brenda near SDSU.",
        cta: "DM SET",
        tint: RGBA(0xa96f78)
    ),
    Concept(
        slug: "private-studio",
        imagePath: "public/images/nails-summer-nude-rings.jpg",
        kicker: "College Area",
        headline: "Private nail studio near SDSU.",
        subhead: "Clean prep. Custom sets. One-on-one with Brenda.",
        cta: "Book with Brenda",
        tint: RGBA(0x60715d)
    ),
    Concept(
        slug: "builder-gel",
        imagePath: "public/assets/builder.jpg",
        kicker: "Builder gel",
        headline: "Cute nails, but make them your real nails.",
        subhead: "For clients who want strength, structure, and a clean grow-out.",
        cta: "DM GROW",
        tint: RGBA(0x60715d)
    ),
    Concept(
        slug: "occasion-set",
        imagePath: "public/images/nails-vacation.jpg",
        kicker: "Trips + photos",
        headline: "Book the set before the plans.",
        subhead: "Custom nails in College Area for birthdays, trips, and weekends.",
        cta: "DM SET",
        tint: RGBA(0xc4a36d)
    )
]

func loadImage(_ path: String) throws -> CGImage {
    let url = root.appendingPathComponent(path) as CFURL
    guard
        let source = CGImageSourceCreateWithURL(url, nil),
        let image = CGImageSourceCreateImageAtIndex(source, 0, nil)
    else {
        throw NSError(domain: "render", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not load \(path)"])
    }
    return image
}

func drawCover(_ image: CGImage, in context: CGContext, width: Int, height: Int) {
    let iw = CGFloat(image.width)
    let ih = CGFloat(image.height)
    let targetAspect = CGFloat(width) / CGFloat(height)
    let sourceAspect = iw / ih
    var crop = CGRect(x: 0, y: 0, width: iw, height: ih)

    if sourceAspect > targetAspect {
        let cropWidth = ih * targetAspect
        crop.origin.x = (iw - cropWidth) / 2
        crop.size.width = cropWidth
    } else {
        let cropHeight = iw / targetAspect
        crop.origin.y = (ih - cropHeight) / 2
        crop.size.height = cropHeight
    }

    guard let cropped = image.cropping(to: crop.integral) else { return }
    context.draw(cropped, in: CGRect(x: 0, y: 0, width: width, height: height))
}

func drawLinearGradient(_ context: CGContext, rect: CGRect, colors: [RGBA], locations: [CGFloat], start: CGPoint, end: CGPoint) {
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors.map { $0.cgColor() } as CFArray, locations: locations) else {
        return
    }
    context.saveGState()
    context.clip(to: rect)
    context.drawLinearGradient(gradient, start: start, end: end, options: [])
    context.restoreGState()
}

func drawText(
    _ context: CGContext,
    text: String,
    x: CGFloat,
    y: CGFloat,
    width: CGFloat,
    height: CGFloat,
    fontName: String,
    fontSize: CGFloat,
    color: RGBA,
    lineHeight: CGFloat = 0.9,
    kern: CGFloat = 0
) {
    var lineSpacing = fontSize * (lineHeight - 1)
    var lineBreak = CTLineBreakMode.byWordWrapping
    let paragraph = withUnsafePointer(to: &lineSpacing) { lineSpacingPointer in
        withUnsafePointer(to: &lineBreak) { lineBreakPointer in
            let settings = [
                CTParagraphStyleSetting(spec: .lineSpacingAdjustment, valueSize: MemoryLayout<CGFloat>.size, value: lineSpacingPointer),
                CTParagraphStyleSetting(spec: .lineBreakMode, valueSize: MemoryLayout<CTLineBreakMode>.size, value: lineBreakPointer)
            ]
            return CTParagraphStyleCreate(settings, settings.count)
        }
    }
    let font = CTFontCreateWithName(fontName as CFString, fontSize, nil)
    let attributes: [CFString: Any] = [
        kCTFontAttributeName: font,
        kCTForegroundColorAttributeName: color.cgColor(),
        kCTParagraphStyleAttributeName: paragraph,
        kCTKernAttributeName: kern
    ]
    let attributed = CFAttributedStringCreate(nil, text as CFString, attributes as CFDictionary)!
    let framesetter = CTFramesetterCreateWithAttributedString(attributed)

    context.saveGState()
    context.textMatrix = .identity
    let path = CGMutablePath()
    path.addRect(CGRect(x: x, y: CGFloat(context.height) - y - height, width: width, height: height))
    let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
    CTFrameDraw(frame, context)
    context.restoreGState()
}

func drawSingleLine(
    _ context: CGContext,
    text: String,
    x: CGFloat,
    y: CGFloat,
    fontName: String,
    fontSize: CGFloat,
    color: RGBA,
    kern: CGFloat = 0
) -> CGSize {
    let font = CTFontCreateWithName(fontName as CFString, fontSize, nil)
    let attributes: [CFString: Any] = [
        kCTFontAttributeName: font,
        kCTForegroundColorAttributeName: color.cgColor(),
        kCTKernAttributeName: kern
    ]
    let attributed = CFAttributedStringCreate(nil, text as CFString, attributes as CFDictionary)!
    let line = CTLineCreateWithAttributedString(attributed)
    let bounds = CTLineGetBoundsWithOptions(line, [])

    context.saveGState()
    context.textMatrix = .identity
    context.textPosition = CGPoint(x: x, y: CGFloat(context.height) - y - bounds.height * 0.15)
    CTLineDraw(line, context)
    context.restoreGState()
    return CGSize(width: bounds.width, height: bounds.height)
}

func roundRectPath(_ rect: CGRect, radius: CGFloat) -> CGPath {
    let path = CGMutablePath()
    path.addRoundedRect(in: rect, cornerWidth: radius, cornerHeight: radius)
    return path
}

func drawPill(_ context: CGContext, text: String, x: CGFloat, yFromTop: CGFloat, fontSize: CGFloat) {
    let font = CTFontCreateWithName("AvenirNext-Heavy" as CFString, fontSize, nil)
    let attributes: [CFString: Any] = [
        kCTFontAttributeName: font,
        kCTForegroundColorAttributeName: RGBA(0x2f2927).cgColor(),
        kCTKernAttributeName: 1.8
    ]
    let display = text.uppercased()
    let attributed = CFAttributedStringCreate(nil, display as CFString, attributes as CFDictionary)!
    let line = CTLineCreateWithAttributedString(attributed)
    let bounds = CTLineGetBoundsWithOptions(line, [])
    let pillHeight = fontSize * 2.9
    let pillWidth = bounds.width + fontSize * 2.5
    let topRect = CGRect(x: x, y: yFromTop, width: pillWidth, height: pillHeight)
    let rect = CGRect(x: topRect.minX, y: CGFloat(context.height) - topRect.maxY, width: topRect.width, height: topRect.height)

    context.saveGState()
    context.addPath(roundRectPath(rect, radius: pillHeight / 2))
    context.setFillColor(RGBA(0xfff8f1, alpha: 0.96).cgColor())
    context.fillPath()
    context.addPath(roundRectPath(rect, radius: pillHeight / 2))
    context.setStrokeColor(RGBA(0xffffff, alpha: 0.75).cgColor())
    context.setLineWidth(2)
    context.strokePath()
    context.restoreGState()

    context.saveGState()
    context.textMatrix = .identity
    context.textPosition = CGPoint(
        x: rect.minX + fontSize * 1.25,
        y: rect.midY - bounds.midY
    )
    CTLineDraw(line, context)
    context.restoreGState()
}

func render(_ concept: Concept, width: Int, height: Int, suffix: String) throws {
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    guard let context = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
        throw NSError(domain: "render", code: 2, userInfo: [NSLocalizedDescriptionKey: "Could not create context"])
    }

    context.setFillColor(RGBA(0xfff8f1).cgColor())
    context.fill(CGRect(x: 0, y: 0, width: width, height: height))

    let image = try loadImage(concept.imagePath)
    drawCover(image, in: context, width: width, height: height)

    drawLinearGradient(
        context,
        rect: CGRect(x: 0, y: 0, width: width, height: height),
        colors: [RGBA(0x2f2927, alpha: 0.78), concept.tint, RGBA(0x2f2927, alpha: 0.04)],
        locations: [0, 0.58, 1],
        start: CGPoint(x: CGFloat(width) / 2, y: 0),
        end: CGPoint(x: CGFloat(width) / 2, y: CGFloat(height))
    )
    drawLinearGradient(
        context,
        rect: CGRect(x: 0, y: 0, width: CGFloat(width) * 0.72, height: CGFloat(height)),
        colors: [RGBA(0x2f2927, alpha: 0.42), RGBA(0x2f2927, alpha: 0.02)],
        locations: [0, 1],
        start: CGPoint(x: 0, y: CGFloat(height) / 2),
        end: CGPoint(x: CGFloat(width) * 0.72, y: CGFloat(height) / 2)
    )

    let margin: CGFloat = suffix == "story" ? 54 : 44
    let topBrandY = margin
    _ = drawSingleLine(
        context,
        text: "BEAUTY HIVE STUDIO",
        x: margin,
        y: topBrandY,
        fontName: "AvenirNext-Heavy",
        fontSize: 25,
        color: RGBA(0xffffff),
        kern: 3
    )
    _ = drawSingleLine(
        context,
        text: "SAN DIEGO",
        x: CGFloat(width) - margin - 220,
        y: topBrandY + 4,
        fontName: "AvenirNext-Heavy",
        fontSize: 18,
        color: RGBA(0xffffff, alpha: 0.86),
        kern: 2
    )

    let headlineFontSize: CGFloat = suffix == "story" ? 100 : 84
    let bodyFontSize: CGFloat = suffix == "story" ? 34 : 29
    let kickerFontSize: CGFloat = suffix == "story" ? 21 : 20
    let ctaFontSize: CGFloat = suffix == "story" ? 26 : 25
    let bottom: CGFloat = suffix == "story" ? 78 : 48
    let contentWidth = CGFloat(width) - margin * 2
    let headlineHeight: CGFloat = suffix == "story" ? 390 : 304
    let bodyHeight: CGFloat = suffix == "story" ? 126 : 102
    let ctaHeight = ctaFontSize * 2.9
    let kickerHeight: CGFloat = 46
    let ctaTopY = CGFloat(height) - bottom - ctaHeight
    let subheadTopY = ctaTopY - 34 - bodyHeight
    let headlineTopY = subheadTopY - 26 - headlineHeight
    let kickerTopY = headlineTopY - 22 - kickerHeight

    let kickerText = concept.kicker.uppercased()
    let kickerTextSize = drawSingleLine(
        context,
        text: kickerText,
        x: -10000,
        y: -10000,
        fontName: "AvenirNext-Heavy",
        fontSize: kickerFontSize,
        color: RGBA(0xffffff),
        kern: 2.2
    )
    let kickerRectTop = CGRect(x: margin, y: kickerTopY, width: min(kickerTextSize.width + 30, contentWidth), height: kickerHeight)
    let kickerRect = CGRect(x: kickerRectTop.minX, y: CGFloat(height) - kickerRectTop.maxY, width: kickerRectTop.width, height: kickerRectTop.height)
    context.setFillColor(RGBA(0xffffff, alpha: 0.16).cgColor())
    context.fill(kickerRect)
    context.setStrokeColor(RGBA(0xffffff, alpha: 0.34).cgColor())
    context.setLineWidth(1.2)
    context.stroke(kickerRect)
    _ = drawSingleLine(
        context,
        text: kickerText,
        x: kickerRectTop.minX + 14,
        y: kickerRectTop.minY + 11,
        fontName: "AvenirNext-Heavy",
        fontSize: kickerFontSize,
        color: RGBA(0xffffff),
        kern: 2.2
    )

    drawText(
        context,
        text: concept.headline,
        x: margin,
        y: headlineTopY,
        width: contentWidth,
        height: headlineHeight,
        fontName: "Georgia-Bold",
        fontSize: headlineFontSize,
        color: RGBA(0xffffff),
        lineHeight: 0.88
    )
    drawText(
        context,
        text: concept.subhead,
        x: margin,
        y: subheadTopY,
        width: min(760, contentWidth),
        height: bodyHeight,
        fontName: "AvenirNext-DemiBold",
        fontSize: bodyFontSize,
        color: RGBA(0xffffff, alpha: 0.9),
        lineHeight: 1.04
    )
    drawPill(context, text: concept.cta, x: margin, yFromTop: ctaTopY, fontSize: ctaFontSize)

    guard let outputImage = context.makeImage() else {
        throw NSError(domain: "render", code: 3, userInfo: [NSLocalizedDescriptionKey: "Could not create output image"])
    }
    let outputURL = exportDir.appendingPathComponent("\(concept.slug)-\(suffix).png")
    guard let destination = CGImageDestinationCreateWithURL(outputURL as CFURL, UTType.png.identifier as CFString, 1, nil) else {
        throw NSError(domain: "render", code: 4, userInfo: [NSLocalizedDescriptionKey: "Could not create destination"])
    }
    CGImageDestinationAddImage(destination, outputImage, nil)
    guard CGImageDestinationFinalize(destination) else {
        throw NSError(domain: "render", code: 5, userInfo: [NSLocalizedDescriptionKey: "Could not write PNG"])
    }
    print(outputURL.path)
}

for concept in concepts {
    try render(concept, width: 1080, height: 1350, suffix: "feed")
    try render(concept, width: 1080, height: 1920, suffix: "story")
}
