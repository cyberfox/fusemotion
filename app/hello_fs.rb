class HelloFs
  HELLO_PATH='/hello.txt'

  def initialize
  end

  def contentsOfDirectoryAtPath(path, error: error)
    return [HELLO_PATH.lastPathComponent]
  end

  def contentsAtPath(path)
    if path == HELLO_PATH
      "Hello, world!\n".dataUsingEncoding(NSUTF8StringEncoding)
    end
  end

  def finderAttributesAtPath(path, error: error)
    if path == HELLO_PATH
      finderFlags = NSNumber.numberWithLong(KHasCustomIcon)
      {KGMUserFileSystemFinderFlagsKey => finderFlags}
    end
  end

  def resourceAttributesAtPath(path, error: error)
    if path == HELLO_PATH
      NSBundle.mainBundle.pathForResource("hellodoc", ofType:"icns")
    end
  end
end
