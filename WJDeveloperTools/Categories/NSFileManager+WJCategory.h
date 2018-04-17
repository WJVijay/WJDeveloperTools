//
//  NSFileManager+WJCategory.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Directory type enum
 */
typedef NS_ENUM(NSInteger, DirectoryType) {
    /**
     *  Main bundle directory
     */
    DirectoryTypeMainBundle = 0,
    /**
     *  Library directory
     */
    DirectoryTypeLibrary,
    /**
     *  Documents directory
     */
    DirectoryTypeDocuments,
    /**
     *  Cache directory
     */
    DirectoryTypeCache
};

@interface NSFileManager (WJCategory)

/**
 *  读取一个文件，返回内容为NSString。
 *
 *  @param file File name
 *  @param type File type
 *
 *  @return Returns the content of the file a NSString
 */
+ (NSString * _Nullable)readTextFile:(NSString * _Nonnull)file
                              ofType:(NSString * _Nonnull)type;

/**
 *  将给定的数组保存到带有给定文件名的PLIST中。
 *
 *  @param path     Path of the PLIST
 *  @param fileName PLIST filename
 *  @param array    Array to save into PLIST
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)saveArrayToPath:(DirectoryType)path
           withFilename:(NSString * _Nonnull)fileName
                  array:(NSArray * _Nonnull)array;

/**
 * 用给定的文件名从PLIST加载数组。
 *
 *  @param path     Path of the PLIST
 *  @param fileName PLIST filename
 *
 *  @return Returns the loaded array
 */
+ (NSArray * _Nullable)loadArrayFromPath:(DirectoryType)path
                            withFilename:(NSString * _Nonnull)fileName;

/**
 *  获取文件名的Bundle路径。
 *
 *  @param fileName Filename
 *
 *  @return Returns the path as a NSString
 */
+ (NSString * _Nonnull)getBundlePathForFile:(NSString * _Nonnull)fileName;

/**
 *  获取文件名的文档目录。
 *
 *  @param fileName Filename
 *
 *  @return Returns the directory as a NSString
 */
+ (NSString * _Nonnull)getDocumentsDirectoryForFile:(NSString * _Nonnull)fileName;

/**
 *  获取文件名的库目录。
 *
 *  @param fileName Filename
 *
 *  @return Returns the directory as a NSString
 */
+ (NSString * _Nonnull)getLibraryDirectoryForFile:(NSString * _Nonnull)fileName;

/**
 *  获取文件名的缓存目录。
 *
 *  @param fileName Filename
 *
 *  @return Returns the directory as a NSString
 */
+ (NSString * _Nonnull)getCacheDirectoryForFile:(NSString * _Nonnull)fileName;

/**
 * 返回文件的大小。
 *
 *  @param fileName  Filename
 *  @param directory Directory of the file
 *
 *  @return Returns the file size
 */
+ (NSNumber * _Nullable)fileSize:(NSString * _Nonnull)fileName
                   fromDirectory:(DirectoryType)directory;

/**
 *  删除带有给定文件名的文件。
 *
 *  @param fileName Filename to delete
 *  @param directory   Directory of the file
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)deleteFile:(NSString * _Nonnull)fileName
     fromDirectory:(DirectoryType)directory;

/**
 *  将文件从一个目录移动到另一个目录。
 *
 *  @param fileName    Filename to move
 *  @param origin      Origin directory of the file
 *  @param destination Destination directory of the file
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)moveLocalFile:(NSString * _Nonnull)fileName
        fromDirectory:(DirectoryType)origin
          toDirectory:(DirectoryType)destination;

/**
 *  将文件从一个目录移动到另一个目录。
 *
 *  @param fileName    Filename to move
 *  @param origin      Origin directory of the file
 *  @param destination Destination directory of the file
 *  @param folderName  Folder name where to move the file. If folder not exist it will be created automatically
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)moveLocalFile:(NSString * _Nonnull)fileName
        fromDirectory:(DirectoryType)origin
          toDirectory:(DirectoryType)destination
       withFolderName:(NSString * _Nullable)folderName;

/**
 *  将文件复制到另一个目录中。
 *
 *  @param origin      Origin path
 *  @param destination Destination path
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)duplicateFileAtPath:(NSString * _Nonnull)origin
                  toNewPath:(NSString * _Nonnull)destination;

/**
 *  用另一个文件名重命名一个文件。
 *
 *  @param origin  Origin path
 *  @param path    Subdirectory path
 *  @param oldName Old filename
 *  @param newName New filename
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)renameFileFromDirectory:(DirectoryType)origin
                         atPath:(NSString * _Nonnull)path
                    withOldName:(NSString * _Nonnull)oldName
                     andNewName:(NSString * _Nonnull)newName;

/**
 *  获取给定键的应用程序设置。
 *
 *  @param objKey Key to get the object
 *
 *  @return Returns the object for the given key
 */
+ (id _Nullable)getAppSettingsForObjectWithKey:(NSString * _Nonnull)objKey;

/**
 *  设置给定对象和键的应用程序设置。文件将保存在库目录中。
 *
 *  @param value  Object to set
 *  @param objKey Key to set the object
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)setAppSettingsForObject:(id _Nonnull)value
                         forKey:(NSString * _Nonnull)objKey;

/**
 *  获取给定键的给定设置。
 *
 *  @param settings Settings filename
 *  @param objKey   Key to set the object
 *
 *  @return Returns the object for the given key
 */
+ (id _Nullable)getSettings:(NSString * _Nonnull)settings
               objectForKey:(NSString * _Nonnull)objKey;

/**
 *  设置给定对象和键的给定设置。文件将保存在库目录中。
 *
 *  @param settings Settings filename
 *  @param value    Object to set
 *  @param objKey   Key to set the object
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)setSettings:(NSString * _Nonnull)settings
             object:(id _Nonnull)value
             forKey:(NSString * _Nonnull)objKey;

@end
