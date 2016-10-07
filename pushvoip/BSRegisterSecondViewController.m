//
//  BSRegisterSecondViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 27/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterSecondViewController.h"

@implementation BSRegisterSecondViewController
@synthesize pin1;
@synthesize pin2;
@synthesize pin3;
@synthesize pin4;
@synthesize codeIncorrect;
@synthesize code;
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
    code = @"1234";
    NSLog(@"VIEW DID LOAD");
}
/*
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSLog(@"textFieldShouldReturn");
    if (textField == pin1)
    {
        [pin2 becomeFirstResponder];
    }
    else if (textField == pin2)
    {
        [pin3 becomeFirstResponder];
    }
    else if (textField == pin3)
    {
        [pin4 becomeFirstResponder];
    }
    
    return NO;
}
*/

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // This allows numeric text only, but also backspace for deletes
    NSLog(@"TEST shouldChange %@", string);

    textField.text = @"";
    if (string.length > 0 && ![[NSScanner scannerWithString:string] scanInt:NULL])
        return NO;
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    NSLog(@"newLength %lu", (unsigned long)newLength);
    // This 'tabs' to next field when entering digits
    if (newLength == 1) {
        if (textField == pin1)
        {
            NSLog(@"A");
            //[pin2 becomeFirstResponder];
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
        NSLog(@"TEST %@", pin4.text);
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return newLength <= 1;
}

- (void)textFieldDidChange:(id *)sender
{
    //[self performSelector:@selector(setNextResponder:) withObject:pin1 afterDelay:0];
    if (!([pin4.text isEqualToString:@""] || [pin4.text isEqualToString:@" "])){
        pin4.text = [NSString stringWithFormat:@"%c", [pin4.text characterAtIndex:0]];
        NSLog(@"check code %@ %@ %@ %@", pin1.text, pin2.text, pin3.text, pin4.text);
        sleep(2          );
        if ([pin1.text isEqualToString:[NSString stringWithFormat:@"%c", [code characterAtIndex:0]]] &&
            [pin2.text isEqualToString:[NSString stringWithFormat:@"%c", [code characterAtIndex:1]]] &&
            [pin3.text isEqualToString:[NSString stringWithFormat:@"%c", [code characterAtIndex:2]]] &&
            [pin4.text isEqualToString:[NSString stringWithFormat:@"%c", [code characterAtIndex:3]]]){
            NSLog(@"CODE OK");
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *myController = [sb instantiateViewControllerWithIdentifier:@"BSRegisterThirdViewController"];
            [self.navigationController pushViewController: myController animated:YES];
        } else{
            //[self performSelector:@selector(setNextResponder:) withObject:pin1 afterDelay:0.2];
            [pin1 becomeFirstResponder];
            pin1.text = @"";
            pin2.text = @"";
            pin3.text = @"";
            pin4.text = @"";
            codeIncorrect.textColor = [UIColor redColor];
        }
    }
    //[pin1 becomeFirstResponder];
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
