class AppDelegate
  MOUNT_PATH = "/Volumes/Hello";

  def didMount(notification)
    userInfo = notification.userInfo
    puts userInfo.inspect
    mountPath = userInfo[KGMUserFileSystemMountPathKey]
    parentPath = mountPath.stringByDeletingLastPathComponent
    NSWorkspace.sharedWorkspace.selectFile(mountPath, inFileViewerRootedAtPath: parentPath)
  end

  def didUnmount(notification)
    NSApplication.sharedApplication.terminate(nil)
  end

  def applicationDidFinishLaunching(notification)
    buildWindow

    @center = NSNotificationCenter.defaultCenter

    @center.addObserver(self, selector: :'didMount:', name: KGMUserFileSystemDidMount, object: nil)
    @center.addObserver(self, selector: :'didUnmount:', name: KGMUserFileSystemDidUnmount, object: nil)

    @hello = HelloFs.new

    @fs = GMUserFileSystem.alloc.initWithDelegate(@hello, isThreadSafe: true)

    mount_options = ['rdonly', 'volname=HelloFS', "volicon=#{NSBundle.mainBundle.pathForResource("Fuse", ofType:"icns")}"]
    @fs.mountAtPath(MOUNT_PATH, withOptions: mount_options)
  end

  def applicationShouldTerminate(sender)
    NSNotificationCenter.defaultCenter.removeObserver(self)

    @fs.unmount
    @fs.delegate.release
    @fs.release

    return NSTerminateNow
  end

  def buildWindow
    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength).init.tap do |menubar|
      menubar.setMenu buildMenu
      menubar.button.setImage(NSImage.imageNamed('disc-drive.png'))
    end
  end

  def buildMenu
    appName = NSBundle.mainBundle.infoDictionary['CFBundleName']

    @menu ||= NSMenu.new.tap do |menu|
      menu.initWithTitle appName
      menu.addItem NSMenuItem.separatorItem
      menu.addItem NSMenuItem.alloc.initWithTitle("About #{appName}", action: 'orderFrontStandardAboutPanel:', keyEquivalent: '')
      menu.addItem NSMenuItem.separatorItem
      menu.addItem NSMenuItem.alloc.initWithTitle('Preferences', action: 'openPreferences:', keyEquivalent: ',')
      menu.addItem NSMenuItem.separatorItem
      menu.addItem NSMenuItem.alloc.initWithTitle("Quit #{appName}", action: 'terminate:', keyEquivalent: 'q')
    end
  end
end
