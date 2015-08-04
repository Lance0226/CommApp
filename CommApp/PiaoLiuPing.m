//
//  UIViewController+MutableDialogue.m
//  CommApp
//
//  Created by 韩渌 on 15/8/1.
//  Copyright (c) 2015年 hanlu. All rights reserved.
//

#import "PIaoLiuPing.h"


@implementation PiaoLiuPing

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)selectPhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
- (IBAction)saveImage:(id)sender
{
    [self saveImg:self.imageView.image];
    
}

-(void)saveImg:(UIImage*)image
{
    if (image!=nil) {
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirecotry=[paths objectAtIndex:0];
        NSString *path=[documentDirecotry stringByAppendingPathComponent:@"test.png"];
        NSLog(@"%@",path);
        NSData* data=UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
        
    }
}
- (IBAction)loadImg:(id)sender
{
    UIImage *img=[self loadImage];
    self.imageView.image=img;
}

- (UIImage*)loadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:
                      @"test.png" ];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)dealloc {
    [_imageView release];
    [super dealloc];
}
@end