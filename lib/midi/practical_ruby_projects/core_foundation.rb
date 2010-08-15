module CoreFoundation
  require 'dl/import'
  extend DL::Importer
  dlload '/System/Library/Frameworks/CoreFoundation.framework/Versions/Current/CoreFoundation'

  extern "void * CFStringCreateWithCString (void *, char *, int)"
end
