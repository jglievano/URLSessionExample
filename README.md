URLSessionExample
=================

Find here an example on how to use URLSession on an iOS project with Swift 3.

## UI specifications

The app consists solely of a *collection view* and a *toolbar*. The
**collection view** is used to display images downloaded from a preset list of
URLs. The **toolbar** contains one button that triggers a download for an item
within the URLs list.

## The Image Loader

`ImageLoader` is the class in charge of downloading the images and storing them.
`ImageLoader` provides an **instance method**,
`downloadImage(path:completionHandler:)`, to download images upon request.

`downloadImage` receives two(2) parameters. The first is a `String` with the
URL path and the second is a closure that is called once the request finishes
fetching. Whether the request returns error or not, this callback will be
called. Internally, if there is no error, the downloaded image will be appended
to the list of downloaded images.

## The URLs

The downloaded images comes from a list of preset paths defined on
`ViewController`. Most of this URLs are `http` instead of `https`. This means
they are not secure servers and your app must allow such requests to be made.

To allow requests to `http` URLs, you need to set the configuration properly on
your app's `Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

