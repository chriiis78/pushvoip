//
//  BSRegisterSecondViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 27/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterSecondViewController.h"

#define PUSH_HOST @"admin.aedmap.org"

@implementation BSRegisterSecondViewController
@synthesize pin1;
@synthesize pin2;
@synthesize pin3;
@synthesize pin4;
@synthesize codeIncorrect;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Vérification";
    
    
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Annuler" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;
    pin1.delegate = self;
    pin2.delegate = self;
    pin3.delegate = self;
    pin4.delegate = self;
    [pin1 becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // This allows numeric text only, but also backspace for deletes

    textField.text = @"";
    if (string.length > 0 && ![[NSScanner scannerWithString:string] scanInt:NULL])
        return NO;
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    // This 'tabs' to next field when entering digits
    if (newLength == 1) {
        if (textField == pin1)
        {
            [self performSelector:@selector(setNextResponder:) withObject:pin2 afterDelay:0];
            pin2.text = @" ";
        }
        else if (textField == pin2)
        {
            [self performSelector:@selector(setNextResponder:) withObject:pin3 afterDelay:0];
            pin3.text = @" ";
        }
        else if (textField == pin3)
        {
            [self performSelector:@selector(setNextResponder:) withObject:pin4 afterDelay:0];
            pin4.text = @" ";
        }
    }
    //this goes to previous field as you backspace through them, so you don't have to tap into them individually
    else {
        if (textField == pin4)
        {
            [self performSelector:@selector(setNextResponder:) withObject:pin3 afterDelay:0];
            pin3.text = @" ";
        }
        else if (textField == pin3)
        {
            [self performSelector:@selector(setNextResponder:) withObject:pin2 afterDelay:0];
            pin2.text = @" ";
        }
        else if (textField == pin2)
        {
            [self performSelector:@selector(setNextResponder:) withObject:pin1 afterDelay:0];
            pin1.text = @"";
        }
    }
    if (textField == pin4){
        textField.text = string;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return newLength <= 1;
}

- (void)textFieldDidChange:(id *)sender
{
    if (!([pin4.text isEqualToString:@""] || [pin4.text isEqualToString:@" "])){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        pin4.text = [NSString stringWithFormat:@"%c", [pin4.text characterAtIndex:0]];
        NSString *urlString = [NSString stringWithFormat:@"/apiFirstResponder/accountCheckSMS/%@%@%@%@/%@", pin1.text, pin2.text, pin3.text, pin4.text , [defaults valueForKey:@"WAIT_CODE_TOKEN"]];
        urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL *url = [[NSURL alloc] initWithScheme:@"https" host:PUSH_HOST path:urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            NSString *dataResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[dataResponse dataUsingEncoding:NSUTF8StringEncoding]
                                                                  options:0 error:NULL];
            NSLog(@"jsonObject=%@", jsonObject);
            
            NSString *result = [jsonObject valueForKey:@"result"];
            if ([result isEqualToString:@"OK"]){
                NSArray *account = [jsonObject valueForKey:@"account"];
                NSString *status = [account valueForKey:@"status"];
                if ([status isEqualToString:@"exist"]){
                    [defaults setObject:[account valueForKey:@"phone"] forKey:@"BS_PHONE"];
                    [defaults setObject:[account valueForKey:@"firstname"] forKey:@"BS_FIRSTNAME"];
                    [defaults setObject:[account valueForKey:@"lastname"] forKey:@"BS_LASTNAME"];
                    [defaults setObject:[account valueForKey:@"email"] forKey:@"BS_EMAIL"];
                } else{
                    [defaults setObject:nil forKey:@"BS_PHONE"];
                    [defaults setObject:nil forKey:@"BS_FIRSTNAME"];
                    [defaults setObject:nil forKey:@"BS_LASTNAME"];
                    [defaults setObject:nil forKey:@"BS_EMAIL"];
                    
                }
                [defaults setObject:[jsonObject valueForKey:@"cgu"] forKey:@"BS_CGU"];
                [defaults setObject:[jsonObject valueForKey:@"displayGender"] forKey:@"BS_DISPLAY_GENDER"];
                [defaults setObject:[jsonObject valueForKey:@"displayZipCode"] forKey:@"BS_DISPLAY_ZIPCODE"];
                [defaults setObject:[jsonObject valueForKey:@"skill"] forKey:@"BS_SKILL"];
                [defaults synchronize];
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *myController = [sb instantiateViewControllerWithIdentifier:@"BSRegisterThirdViewController"];
                [self.navigationController pushViewController: myController animated:YES];
            } else{
                [pin1 becomeFirstResponder];
                pin1.text = @"";
                pin2.text = @"";
                pin3.text = @"";
                pin4.text = @"";
                codeIncorrect.textColor = [UIColor redColor];
            }
        
         
#ifdef DEBUG
            NSLog(@"error : %@", [error description]);
            NSLog(@"Register URL: %@%@", PUSH_HOST, urlString);
#endif
        }];
        [pin4 resignFirstResponder];
    }
}

- (void)setNextResponder:(UITextField *)nextResponder
{
    [nextResponder becomeFirstResponder];
}

-(void)btnOnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)returnFirstView:(UIButton *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"WAIT_CODE_TOKEN"];
    [defaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
