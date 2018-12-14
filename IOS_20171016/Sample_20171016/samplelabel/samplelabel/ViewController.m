//
//  ViewController.m
//  samplebarcode
//
//  Created by 彭书旗 on 16/4/23.
//  Copyright © 2016年 开聪电子. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <BLEPrintingDiscoverDelegate>

@property AppDelegate * myApp;
// 搜索到的蓝牙设备都会出现在这里了
@property NSMutableArray * arrayPeripehral;
@property NSMutableArray * arrayPeripheralName;
@property UITextField * tfRec;
@property UIScrollView * scrollView;

- (void)handleSearchBT:(id)sender;

- (void)handleConnect:(id)sender;

- (void)handlePrint:(id)sender;

- (void)handleDisconnect:(id)sender;

@end

@implementation ViewController

@synthesize myApp,arrayPeripehral,arrayPeripheralName,tfRec,scrollView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    myApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    myApp.myBle.myDiscoverDelegate = self;
    arrayPeripehral = [[NSMutableArray alloc] init];
    arrayPeripheralName = [[NSMutableArray alloc] init];
    
    UIColor *randomColor = [UIColor colorWithRed:255/255. green:200/255. blue:0. alpha:1.f];
    
    self.view.backgroundColor = randomColor;
    //self.view.layer.borderColor = [UIColor orangeColor].CGColor;
    //self.view.layer.borderWidth = 2.f;
    
    int width = self.view.bounds.size.width;
    int height = self.view.bounds.size.height;
    
    UITextField * tf1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    tf1.textAlignment = NSTextAlignmentCenter;
    tf1.enabled = false;
    [self.view addSubview:tf1];
    
    tfRec = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, width, 60)];
    tfRec.textAlignment = NSTextAlignmentCenter;
    tfRec.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tfRec.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    tfRec.text = @"";
    tfRec.enabled = false;
    [self.view addSubview:tfRec];
    
    UIButton * buttonSearchBT = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonSearchBT setTitle:@"搜索" forState:UIControlStateNormal];
    buttonSearchBT.frame = CGRectMake(0, 80, width, 60);
    buttonSearchBT.backgroundColor = [UIColor orangeColor];
    buttonSearchBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    buttonSearchBT.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [buttonSearchBT addTarget:self action:@selector(handleSearchBT:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSearchBT];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 140, width, height - 260)];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    UIButton * buttonDisconnect = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonDisconnect setTitle:@"断开" forState:UIControlStateNormal];
    buttonDisconnect.frame = CGRectMake(0, height - 120, width, 58);
    buttonDisconnect.backgroundColor = [UIColor orangeColor];
    buttonDisconnect.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    buttonDisconnect.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [buttonDisconnect addTarget:self action:@selector(handleDisconnect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonDisconnect];
    
    UIButton * buttonPrint = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonPrint setTitle:@"打印" forState:UIControlStateNormal];
    buttonPrint.frame = CGRectMake(0, height - 60, width, 58);
    buttonPrint.backgroundColor = [UIColor orangeColor];
    buttonPrint.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    buttonPrint.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [buttonPrint addTarget:self action:@selector(handlePrint:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonPrint];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self handleSearchBT:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSearchBT:(id)sender
{
#if 1
    [arrayPeripehral removeAllObjects];
    [arrayPeripheralName removeAllObjects];
    for (UIView * subview in [scrollView subviews])
    {
        if([subview isKindOfClass:[UIButton class]])
        {
            [subview removeFromSuperview];
        }
    }
    
    [myApp.myBle scan];
#endif
    
#if 0
    // IOS Simulators
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        if ([myApp.myNet Open:@"192.168.1.83" portNumber:9100]) {
            [myApp.myPos SetIO:myApp.myNet];
            [self printContent];
            [myApp.myNet Close];
        }
    }
#endif
}

- (int)printContent
{
    // 连接成功之后，打印一张测试页。
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    [myApp.myLabel PageBegin:0 starty:0 width:384 height:500 rotate:0];
    [myApp.myLabel DrawPlainText:12 starty:40 font:24 style:0 str:(char *)[@"测试" cStringUsingEncoding:enc]];
    [myApp.myLabel DrawBarcode:12 starty:100 type:8 height:50 unitwidth:2 rotate:0 str:"NO.20160423"];
    [myApp.myLabel DrawQRCode:12 starty:200 version:0 ecc:4 unitwidth:4 rotate:0 str:"Caysn"];
    [myApp.myLabel DrawBitmap:100 starty:300 width:50 height:80 style:0 img:[UIImage imageNamed:@"yellowmen.png"] nBinaryAlgorithm:0];
    [myApp.myLabel PageEnd];
    [myApp.myLabel PagePrint:1];
    
    int ret = [myApp.myPos POS_TicketSucceed:0 timeout:30000];
    
    NSLog(@"%@", [NSString stringWithFormat:@"POS_TicketSucceed ret:%d", ret]);
    
    return ret;
}

- (void)handleConnect:(id)sender
{
    UIButton * btn = sender;
    
    if ([myApp.myBle IsOpened]) {
        tfRec.text = @"Please disconnect first ...\r\n";
        return;
    }
    
    [myApp.myBle stopScan];
    
    long index = [arrayPeripheralName indexOfObject:[btn titleForState:UIControlStateNormal]];
    
    CBPeripheral * peripheral = arrayPeripehral[index];
    
    tfRec.text = @"Connecting...\r\n";
    
    dispatch_async(myApp.myQueue, ^{
        // 耗时的操作
        if([myApp.myBle Open:peripheral])
        {
            [myApp.myPos SetIO:myApp.myBle];
            [myApp.myLabel SetIO:myApp.myBle];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                tfRec.text = @"Connected\r\n";
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                tfRec.text = @"Failed\r\n";
            });
        }
    });
}

- (void)handleDisconnect:(id)sender
{
    [myApp.myBle Close];
    tfRec.text = @"Disconnected\r\n";
}

- (void)handlePrint:(id)sender
{
    tfRec.text = @"正在打印...\r\n";
    dispatch_async(myApp.myQueue, ^{
        int ret = [self printContent];
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (ret) {
                case 0:
                    tfRec.text = @"打印成功";
                    break;
                case -1:
                    tfRec.text = @"连接断开或已关闭,请检查设备";
                    break;
                case -2:
                    tfRec.text = @"发送失败";
                    break;
                case -3:
                    tfRec.text = @"打印机无响应";
                    break;
                case -4:
                    tfRec.text = @"打印机脱机";
                    break;
                case -5:
                    tfRec.text = @"打印机因缺纸而中断打印";
                    break;
                case -6:
                    tfRec.text = @"其他原因";
                default:
                    break;
            }
        });
    });
}

// BLEPrintingDelegate
- (void)didDiscoverBLE:(CBPeripheral *)peripheral address:(NSString *)address rssi:(int)rssi
{
    // 更新界面
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Handle Discovery
        if([arrayPeripehral containsObject:peripheral])
            return;
        
        [arrayPeripehral addObject:peripheral];
        
        NSString * title = [NSString stringWithFormat:@"%@ %@ (RSSI:%d)", peripheral.name, address, rssi];
        
        [arrayPeripheralName addObject:title];
        
        int width = self.view.bounds.size.width;
        //int height = self.view.bounds.size.height;
        
        UIButton * button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        button1.frame = CGRectMake(30, ([arrayPeripheralName count]-1)*40, width-60, 40);
        button1.backgroundColor = [UIColor lightGrayColor];
        [button1 setTitle:title  forState:UIControlStateNormal];
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button1 addTarget:self action:@selector(handleConnect:) forControlEvents:UIControlEventTouchUpInside];
        scrollView.contentSize = CGSizeMake(width, [arrayPeripheralName count]*40);
        [scrollView addSubview:button1];
        
    });
}

@end

