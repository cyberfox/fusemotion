# fusemotion
RubyMotion MacFuse sample app.  This demonstrates creating user-space file systems in Ruby via RubyMotion.

Running this requires [FUSE for macOS](https://osxfuse.github.io/) installed.  Installing that package will install a framework in `/Library/Frameworks/OSXFUSE` which the sample app embeds.

It should be able to be run as simply as:

    rake

...which will launch as a System Toolbar app, putting an icon in the toolbar.

The app is derived from [a FUSE sample filesystem](https://github.com/osxfuse/filesystems/tree/master/filesystems-objc/HelloFS) which is under the Apache 2.0 license.

The disc image in `resources/disc-drive.png` is _not_ an open source icon, it's from the brilliant [Symbolicons Pro](https://symbolicons.com/) set.

Don't hesitate to open an issue if it's not working, or there's a problem.

Enjoy creating filesystems in Ruby!
