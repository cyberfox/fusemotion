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
    buildMenu
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
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
  end
end
