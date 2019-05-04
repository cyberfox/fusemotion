class HelloFs
  ICON_FILE = NSBundle.mainBundle.pathForResource("hellodoc", ofType:"icns")
  ICON_DATA = NSData.dataWithContentsOfFile(ICON_FILE)

  FILES = {
    '/hello.txt' => {
      attributes: { NSFileType => NSFileTypeRegular  },
      finderAttributes: { KGMUserFileSystemFinderFlagsKey => KHasCustomIcon },
      resourceAttributes: { KGMUserFileSystemCustomIconDataKey => ICON_DATA },
      body: "Hello, world!\n".dataUsingEncoding(NSUTF8StringEncoding)
    }
  }

  def initialize
  end

  def contentsOfDirectoryAtPath(path, error: error)
    return FILES.keys.map(&:lastPathComponent)
  end

  def contentsAtPath(path)
    FILES[path][:body] if FILES.include? path
  end

  def attributesOfItemAtPath(path, userData: userData, error: error)
    if FILES.include? path
      file = FILES[path]
      file_attributes = file[:attributes]
      file_attributes.merge(NSFileSize => file[:body].length)
    end
  end

  def finderAttributesAtPath(path, error: error)
    FILES[path][:finderAttributes] if FILES.include? path
  end

  def resourceAttributesAtPath(path, error: error)
    FILES[path][:resourceAttributes] if FILES.include? path
  end
end
