class HelloFs
  HELLO_PATH='/hello.txt'

  def initialize
    @body = "Hello, world!\n".dataUsingEncoding(NSUTF8StringEncoding)
    icon_file = NSBundle.mainBundle.pathForResource("hellodoc", ofType:"icns")
    @icon_data = NSData.dataWithContentsOfFile(icon_file)
  end

  def contentsOfDirectoryAtPath(path, error: error)
    return [HELLO_PATH.lastPathComponent]
  end

  def contentsAtPath(path)
    @body if path == HELLO_PATH
  end

  def attributesOfItemAtPath(path, userData: userData, error: error)
    { NSFileSize => @body.length, NSFileType => NSFileTypeRegular  } if path == HELLO_PATH
  end

  def finderAttributesAtPath(path, error: error)
    { KGMUserFileSystemFinderFlagsKey => KHasCustomIcon } if path == HELLO_PATH
  end

  def resourceAttributesAtPath(path, error: error)
    { KGMUserFileSystemCustomIconDataKey => @icon_data } if path == HELLO_PATH
  end
end
