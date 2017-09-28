//
//  Print.m
//  BTDemo
//
//  Created by ble on 14-10-31.
//
//

#import "Print.h"


@interface Print ()


@end

@implementation Print


- (BOOL) printBin:(NSData *)bin
{
    //NSLog(@"%@",bin);
    sendDataComplete=(int)[bin length];
    
    if(self.parent.activeDevice==nil || !(self.parent.activeDevice.state==CBPeripheralStateConnected))
    {
        return NO;
    }
    
    if ( isBuffedWrite == YES)
    {
        //NSLog(@"isBufferedWrite==YES");
        if (NO==[self putInBuf:bin])
        {
            NSLog(@"put bin=%@fail",bin);
            return NO;
        }
        else
        {
            if ( taskInRunning==NO )
            {
                taskInRunning = YES;
                //[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(SendTask) userInfo:nil repeats:NO];
                NSThread *t=[[NSThread alloc] initWithTarget:self selector:@selector(SendTask) object:nil];
                [t start];
                //NSLog(@"start sendTask");
                
            }
            return YES;
        }
    }
    else
    {
        NSLog(@"isBufferedWrite==NO");
        
        //if([activeDevice writeData:bin]) return YES;
        [self.parent.activeDevice writeValue:bin forCharacteristic:self.parent.activeWriteCharacteristic type:CBCharacteristicWriteWithResponse];
        //else return NO;
        return YES;
    }
}
- (BOOL) printTxt:(NSString *)txt
{
    //Boolean ret;
    if(self.parent.activeDevice==nil || !self.parent.activeDevice) return NO;
    
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data=[txt dataUsingEncoding:enc];
    //Byte *b = (Byte*)[data bytes];
    if ( isBuffedWrite == YES)
    {
        
        if (NO==[self putInBuf:data])
        {
            NSLog(@"put data=%@fail",data);
            return NO;
        }
        else
        {
            if ( taskInRunning==NO )
            {
                taskInRunning = YES;
                [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(SendTask) userInfo:nil repeats:NO];
            }
            return YES;
        }
    }
    else
    {
    		
        /*ret=[activeDevice writeData:data];
        if(ret==true) return YES;
        return NO;*/
        [self.parent.activeDevice writeValue:data forCharacteristic:self.parent.activeWriteCharacteristic type:CBCharacteristicWriteWithResponse];
        return YES;
    }
}
- (BOOL) printAlignCenter
{
    Byte byte[] = {0x1b,0x61,0x01};//打印居中
    NSData *data = [[NSData alloc] initWithBytes:byte length:3];
    if(![self printBin:data]) return NO;
    return YES;
}
- (BOOL) printAlignLeft
{
    Byte byte[] = {0x1b,0x61,0x00};//打印靠左
    NSData *data = [[NSData alloc] initWithBytes:byte length:3];
    if(![self printBin:data]) return NO;
    return YES;
}
- (BOOL) printAlignRight
{
    Byte byte[] = {0x1b,0x61,0x02};//打印靠右
    NSData *data = [[NSData alloc] initWithBytes:byte length:3];
    if(![self printBin:data]) return NO;
    return YES;
}
- (BOOL) sendCheckPaperOutCmd
{
    Byte byte[] = {0x10,0x04,0x04};//纸传感器状态指令
    NSData *data = [[NSData alloc] initWithBytes:byte length:3];
    if(![self printBin:data]) return NO;
    return YES;
}
- (BOOL) sendCheckOfflineCmd
{
    Byte byte[] = {0x10,0x04,0x01};//打印机状态指令
    NSData *data = [[NSData alloc] initWithBytes:byte length:3];
    if(![self printBin:data]) return NO;
    return YES;
}
- (BOOL) sendCheckErrorCmd
{
    Byte byte[] = {0x10,0x04,0x03};//错误状态指令
    NSData *data = [[NSData alloc] initWithBytes:byte length:3];
    if(![self printBin:data]) return NO;
    return YES;
}
- (BOOL) print2DBarCode:(int)type para1:(int)v para2:(int)r para3:(int)k content:(NSData*)data
{
    Byte byte[10];
    //发GS Z n选择条码类型
    byte[0]=0x1d;
    byte[1]=0x5a;
    byte[2]=type;
    
    //发ESC Z v r nl nh d1...dn
    byte[3]=0x1b;
    byte[4]=0x5a;
    byte[5]=v;
    byte[6]=r;
    byte[7]=k;
    byte[8]=[data length]%256;
    byte[9]=[data length]/256;
    
    NSData *cmd = [[NSData alloc] initWithBytes:byte length:10];
    if(![self printBin:cmd]) return NO;
    if(![self printBin:data]) return NO;
    return YES;

}
- (BOOL) print1DBarCode:(int)type width:(int)w height:(int)h txtpositon:(int)positon content:(NSData*)data;
{
    Byte byte[13+[data length]];
    NSData * cmd;
    //发GS W n设置宽度
    byte[0]=0x1d;
    byte[1]=0x77;
    byte[2]=w;
    
    //发GS h n设置高度
    byte[3]=0x1d;
    byte[4]=0x68;
    byte[5]=h;
    
    //发GS H n设置文字位置
    byte[6]=0x1d;
    byte[7]=0x48;
    byte[8]=positon;
    
    if (type>=0 && type<=6)
    {
        //发GS k m d1...dk nul打印
        byte[9]=0x1d;
        byte[10]=0x6b;
        byte[11]=type;
        Byte *b=(Byte*)[data bytes];
        memcpy(byte+12,b,[data length]);
        byte[12+[data length]-1]=0x00;
        cmd = [[NSData alloc] initWithBytes:byte length:(12+[data length])];
    }
    else if (type>=65 && type<=73)
    {
        //发GS k m n d1...dn打印
        byte[9]=0x1d;
        byte[10]=0x6b;
        byte[11]=type;
        byte[12]=[data length];
        Byte *b=(Byte*)[data bytes];
        memcpy(byte+13,b,[data length]);
        cmd = [[NSData alloc] initWithBytes:byte length:(13+[data length])];
    }
    else return false;
    //NSLog(@"cmd=%@",cmd);
    if(![self printBin:cmd]) return NO;
    return YES;
    
}
- (BOOL) printBitMap:(int)mode bitmap:(NSData*)bm
{
    Byte byte[5+[bm length]];
    NSData * cmd;
    //发ESC * m nl nh d1...dn(1b 2a m nl nh dl...dk)
    byte[0]=0x1b;
    byte[1]=0x2a;
    byte[2]=mode;
    byte[3]=[bm length]%256;
    byte[4]=[bm length]/256;
    
    Byte *b=(Byte*)[bm bytes];
    memcpy(byte+5, b, [bm length]);
    cmd = [[NSData alloc] initWithBytes:byte length:5+[bm length]];
    //NSLog(@"cmd=%@",cmd);
    if(![self printBin:cmd]) return NO;
    return YES;
}
- (BOOL) setLineHeight:(int)n
{
    Byte byte[3];
    NSData * cmd;
    //发ESC 3 n(1b 33 n)
    byte[0]=0x1b;
    byte[1]=0x33;
    byte[2]=n;
    cmd = [[NSData alloc] initWithBytes:byte length:3];
    if(![self printBin:cmd]) return NO;
    return YES;

}
- (BOOL) restoreDefaultLineHeight
{
    Byte byte[2];
    NSData * cmd;
    //发ESC 2 (1b 32)
    byte[0]=0x1b;
    byte[1]=0x32;
    cmd = [[NSData alloc] initWithBytes:byte length:2];
    if(![self printBin:cmd]) return NO;
    return YES;
   
}
- (BOOL) setChineseWordFormat:(BOOL)isDoubleHeight doubleWidth:(BOOL)isDoubleWidth underline:(BOOL)isUnderLine
{
    Byte byte[3];
    NSData * cmd;
    //发FS ! n (1c 21 n)
    byte[0]=0x1c;
    byte[1]=0x21;
    byte[2]=0;
    if ( isDoubleHeight==YES ) byte[2] |= 0x08;
    else byte[2] &= 0xf7;
    
    if ( isDoubleWidth==YES ) byte[2] |= 0x04;
    else byte[2] &= 0xfb;
    
    if ( isUnderLine==YES ) byte[2] |= 0x80;
    else byte[2] &= 0xfb;
    
    cmd = [[NSData alloc] initWithBytes:byte length:3];
    if(![self printBin:cmd]) return NO;
    return YES;

    
}

- (BOOL) setAsciiWordFormat:(int)type bold:(BOOL)isbold doubleHeight:(BOOL)isDoubleHeight doubleWidth:(BOOL)isDoubleWidth underline:(BOOL)isUnderLine
{
    Byte byte[3];
    NSData * cmd;
    //发ESC ! n (1b 21 n)
    byte[0]=0x1b;
    byte[1]=0x21;
    byte[2]=0;
    
    if ( type==1 ) byte[2] |= 0x01;
    
    if ( isbold==YES ) byte[2] |= 0x08;
    else byte[2] &= 0xf7;

    
    if ( isDoubleHeight==YES ) byte[2] |= 0x10;
    else byte[2] &= 0xef;
    
    if ( isDoubleWidth==YES ) byte[2] |= 0x20;
    else byte[2] &= 0xdf;
    
    if ( isUnderLine==YES ) byte[2] |= 0x80;
    else byte[2] &= 0xfb;

    cmd = [[NSData alloc] initWithBytes:byte length:3];
    if(![self printBin:cmd]) return NO;
    return YES;

}

- (void) buffedWriteCtrl:(BOOL)isBuffed
{
    isBuffedWrite = isBuffed;
    NSLog(@"isbuffedWrite=%d",isBuffedWrite);
}

//head+1 point to first data postion,fetch start position
//tail point to last data positon positon,
- (BOOL) putInBuf:(NSData *)data
{
    int dataLen = (int)[data length];
    Byte *b = (Byte*)[data bytes];
    int emptyLen;
    
    if (tail>=head)
    {
        emptyLen=(BUF_SIZE-(tail-head));
        //NSLog(@"before head=%d,tail=%d,emptyLen=%d",head,tail,emptyLen);
        
        if ( emptyLen<dataLen ) return NO;//no place to put
        if ( (BUF_SIZE-tail-1)>=dataLen )
        {
            memcpy(sndBuf+tail+1, b, dataLen);
            tail +=dataLen;
            //if (tail>=BUF_SIZE) tail=0;
        }
        else
        {
            memcpy(sndBuf+tail+1, b, BUF_SIZE-tail-1);
            memcpy(sndBuf,b+BUF_SIZE-tail-1,dataLen-(BUF_SIZE-tail-1));
            tail=dataLen-(BUF_SIZE-tail-1)-1;
        }
    }
    else
    {
        emptyLen=head-tail;
        
        //NSLog(@"before head=%d,tail=%d,emptyLen=%d",head,tail,emptyLen);
        if (emptyLen<dataLen) return NO;//no place to put
        memcpy(sndBuf+tail+1, b, dataLen);
        tail += dataLen;
    }
    //NSLog(@"after head=%d,tail=%d",head,tail);
    return YES;
}
- (NSData *)getFromBuf
{
    Byte b[GET_NUM];
    int dataLen=0,leftLen=0;
    if ( head == tail ) return nil;
    if ( head>tail)
    {
        if ( (BUF_SIZE-head-1)>=GET_NUM ) //have enough data,no wrap
        {
            dataLen = GET_NUM;
            memcpy(b, sndBuf+head+1, GET_NUM);
            head += GET_NUM;
        }
        else
        {
            dataLen = BUF_SIZE-head-1;
            if (dataLen>0) memcpy(b, sndBuf+head+1, dataLen);
            leftLen = GET_NUM - dataLen;
            
            if (leftLen>=(tail+1)) leftLen=tail+1;
            memcpy(b+dataLen, sndBuf, leftLen);
            dataLen += leftLen;
            head = leftLen-1;
        }
    }
    else
    {
        if ((tail-head)<GET_NUM ) dataLen=tail-head;
        else dataLen = GET_NUM;
        memcpy(b, sndBuf+head+1, dataLen);
        head += dataLen;
    }
    //NSLog(@"getfrom head=%d,tail=%d",head,tail);
    NSData *data = [[NSData alloc] initWithBytes:b length:dataLen];
    //[data retain];
    return data;
}

- (BOOL) isBuffEmpty
{
    if ( head == tail ) return YES;
    else return NO;
}
- (void) SendTask
{
    //NSLog(@"SendTask started");
    int interval=0.1;
    
    NSData *data;
    if ( lastData!=nil )        //上次有发送失败的，优先发送
    {
        data = [[NSData alloc] initWithData:lastData];
        lastData=nil;
        //NSLog(@"datafromlast=%@",data);
    }
    
    data = [self getFromBuf];
        //NSLog(@"getFromBuf=%@",data);
    
    if ( data==nil)
    {
        taskInRunning=NO;
        sendDataComplete=0;
        NSLog(@"stop SendTask");
    }
    else if ([data length] > 0 )
    {
          NSLog(@"datalen=%d",(int)[data length]);
        
          sendDataComplete=sendDataComplete-(int)[data length];
        
           [self.parent.activeDevice writeValue:data forCharacteristic:self.parent.activeWriteCharacteristic type:CBCharacteristicWriteWithResponse];
        Boolean ret=YES;
        {
            if (!ret)
            {
                
                NSLog(@"write data failed");
                lastData = [[NSMutableData alloc] initWithData:data];
                NSLog(@"lastData=%@ failed",lastData);
                interval = 1;
            }
            else interval=0.1;
        }
        
        if ( NO==[self isBuffEmpty] || lastData!=nil )
        {
            [NSThread sleepForTimeInterval:interval];
            NSThread *t=[[NSThread alloc] initWithTarget:self selector:@selector(SendTask) object:nil];
            [t start];
        }
        else
        {
            taskInRunning=NO;
        }
        
        //数据发送完毕
        if(sendDataComplete<=0)
        {
            
        }
    }
    else
    {
        //数据长度为0
        
    }
    
}

- (BOOL) printImage:(UIImage *)image
{
    
    Byte BayerPattern[8][8] =
				{
                    {0, 32,  8, 40,  2, 34, 10, 42},
                    {48, 16, 56, 24, 50, 18, 58, 26},
                    {12, 44,  4, 36, 14, 46,  6, 38},
                    {60, 28, 52, 20, 62, 30, 54, 22},
                    {3, 35, 11, 43,  1, 33,  9, 41},
                    {51, 19, 59, 27, 49, 17, 57, 25},
                    {15, 47,  7, 39, 13, 45,  5, 37},
                    {63, 31, 55, 23, 61, 29, 53, 21}
                };
    
    int imageWidth = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    int	bytesPerLine = (imageWidth+7)/8;
    Byte bitmap[imageHeight][bytesPerLine];
    
    for (int i = 0; i < imageHeight; i++)
        for (int j = 0; j < bytesPerLine; j++)
            bitmap[i][j] = 0;
				
    //遍历像素,生成打印点阵
    
    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < imageHeight; i++)
    {
        for (int j = 0; j < imageWidth; j++)
        {
            int grey = pCurPtr[imageWidth*i+j];
            
            int red = ((grey & 0x00FF0000) >> 16);
            int green = ((grey & 0x0000FF00) >> 8);
            int blue = (grey & 0x000000FF);
            
            grey = (int) (red * 0.3 + green * 0.59 + blue * 0.11);
            if( (grey>>2)<BayerPattern[i%8][j%8] )
            {
                bitmap[i][j/8] |= 1<<(7-(j%8));
            }
        }
    }
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(rgbImageBuf);
    Byte lineData[(4+bytesPerLine)*imageHeight+6];
    NSLog(@"datesize=%d",(4+bytesPerLine)*imageHeight+6);
    lineData[(4+bytesPerLine)*imageHeight+3]=0x1d;
    lineData[(4+bytesPerLine)*imageHeight+4]=0x44;
    lineData[(4+bytesPerLine)*imageHeight+5]=0x0;
    for (int n = 0; n < imageHeight; n++)
    {
        lineData[3+(4+bytesPerLine)*n]=0x16;
        lineData[3+(4+bytesPerLine)*n+1]=bytesPerLine;
        for ( int m=0;m<bytesPerLine;m++) lineData[3+(4+bytesPerLine)*n+2+m]=bitmap[n][m];
        lineData[3+(4+bytesPerLine)*n+bytesPerLine+2]=0x15;
        lineData[3+(4+bytesPerLine)*n+bytesPerLine+3]=0x01;
        
    }
    lineData[0]=0x1d;
    lineData[1]=0x44;
    lineData[2]=0x01;
    NSData *data=[[NSData alloc] initWithBytes:lineData length:(6+(4+bytesPerLine)*imageHeight)];
    NSLog(@"date=%d",(int)[data length]);
    if(![self printBin:data]) return NO;
    else return YES;
    
    
    //return YES;
}

- (BOOL) printPNG_JPG:(NSString *)filename
{

    Byte BayerPattern[8][8] =
				{
					 {0, 32,  8, 40,  2, 34, 10, 42},
					 {48, 16, 56, 24, 50, 18, 58, 26},
					 {12, 44,  4, 36, 14, 46,  6, 38},
					 {60, 28, 52, 20, 62, 30, 54, 22},
					 {3, 35, 11, 43,  1, 33,  9, 41},
					 {51, 19, 59, 27, 49, 17, 57, 25},
					 {15, 47,  7, 39, 13, 45,  5, 37},
					 {63, 31, 55, 23, 61, 29, 53, 21}
				 };

		UIImage *image = [UIImage imageNamed:filename];
		int imageWidth = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);

	int	bytesPerLine = (imageWidth+7)/8;
    Byte bitmap[imageHeight][bytesPerLine];
    
    for (int i = 0; i < imageHeight; i++) 
			for (int j = 0; j < bytesPerLine; j++)
				bitmap[i][j] = 0;
				
		//遍历像素,生成打印点阵

    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < imageHeight; i++) 
    {
			for (int j = 0; j < imageWidth; j++)
			{
				int grey = pCurPtr[imageWidth*i+j];

				int red = ((grey & 0x00FF0000) >> 16);
				int green = ((grey & 0x0000FF00) >> 8);
				int blue = (grey & 0x000000FF);

				grey = (int) (red * 0.3 + green * 0.59 + blue * 0.11);
                
				if( (grey>>2)<BayerPattern[i%8][j%8] )
				{
					bitmap[i][j/8] |= 1<<(7-(j%8));
				}
			}
    }
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(rgbImageBuf);
    Byte lineData[(4+bytesPerLine)*imageHeight+6];
    NSLog(@"datesize=%d",(4+bytesPerLine)*imageHeight+6);
    lineData[(4+bytesPerLine)*imageHeight+3]=0x1d;
    lineData[(4+bytesPerLine)*imageHeight+4]=0x44;
    lineData[(4+bytesPerLine)*imageHeight+5]=0x0;
    for (int n = 0; n < imageHeight; n++)
    {
		  lineData[3+(4+bytesPerLine)*n]=0x16;
          lineData[3+(4+bytesPerLine)*n+1]=bytesPerLine;
		  for ( int m=0;m<bytesPerLine;m++) lineData[3+(4+bytesPerLine)*n+2+m]=bitmap[n][m];
		  lineData[3+(4+bytesPerLine)*n+bytesPerLine+2]=0x15;
		  lineData[3+(4+bytesPerLine)*n+bytesPerLine+3]=0x01;
			
    }
    lineData[0]=0x1d;
    lineData[1]=0x44;
    lineData[2]=0x01;
    NSData *data=[[NSData alloc] initWithBytes:lineData length:(6+(4+bytesPerLine)*imageHeight)];
    NSLog(@"date=%d",(int)[data length]);
    if(![self printBin:data]) return NO;
    else return YES;
  

    //return YES;
}


- (BOOL) cutPaper:(int) mode feed_distance:(int) dis
{
		Byte byte[4];
    NSData * cmd;
    //发GS V m/GS V m n
    byte[0]=0x1d;
    byte[1]=0x56;
    byte[2]=mode;
    if ( mode==0 || mode==1 || mode==48 || mode==49 )
    	cmd = [[NSData alloc] initWithBytes:byte length:3];
    else 
    {
    	byte[3]=dis;
    	cmd = [[NSData alloc] initWithBytes:byte length:4];
    }
    if(![self printBin:cmd]) return NO;
    return YES;
}


- (BOOL) setPrintDesity:(int)desity
{
    if (desity < 0 || desity > 14) return false;
    Byte byte[]={0x1D, 0x28, 0x4B, 0x03, 0x00, 0x48, 0x48, desity};
    NSData *cmd=[[NSData alloc] initWithBytes:byte length:8];
    return [self printBin:cmd];
}

- (BOOL) setPrintSpeed:(int)speed
{
    if (speed > 4 || speed < 0) return false;
    Byte byte[]={0x1D, 0x28, 0x4B, 0x03, 0x00, 0x49, 0x48, speed};
    NSData *cmd=[[NSData alloc] initWithBytes:byte length:8];
    return [self printBin:cmd];
}

- (BOOL) setPrintQulity:(int)qulity
{
    if (qulity > 2 || qulity < 0) return false;
    Byte byte[]={0x1D, 0x28, 0x4B, 0x03, 0x00, 0x51, 0x48, qulity};
    NSData *cmd=[[NSData alloc] initWithBytes:byte length:8];
    return [self printBin:cmd];
}

- (BOOL) setPageType:(int)type
{
    if (type > 2 || type < 0) return false;
    Byte byte[]={0x1D, 0x28, 0x4B, 0x03, 0x00, 0x51, 0x48,  type};
    NSData *cmd=[[NSData alloc] initWithBytes:byte length:8];
    return [self printBin:cmd];
}

- (BOOL) getPrinterStatus:(int)n
{
    Byte byte[]={ 0x10, 0x04, n };
    NSData *cmd=[[NSData alloc] initWithBytes:byte length:3];
    return [self printBin:cmd];
}

- (BOOL) getPrinterStatus2:(int)n
{
    Byte byte[]={ 0x10, 0x06, n };
    NSData *cmd=[[NSData alloc] initWithBytes:byte length:3];
    return [self printBin:cmd];
}

- (BOOL) findPrinterInfo:(int)n
{
    Byte byte[]={ 0x1D, 0x49, n };
    NSData *cmd=[[NSData alloc] initWithBytes:byte length:3];
    return [self printBin:cmd];
}

- (BOOL) queryLen
{
    NSData *cmd=[[NSData alloc] initWithBytes:ORDER_QUERY_LEN length:7];
    return [self printBin:cmd];
}


- (BOOL) getPrintV
{
    NSData *cmd=[[NSData alloc] initWithBytes:ORDER_QUERY_BATTERY length:7];
    return [self printBin:cmd];
}

- (int) queryConnectStatus
{
    return 1;
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSLog(@"%@", error);
}

- (void) saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (BOOL) printLabel:(UIImage*)bitmap lw:(int)labelWidth lh:(int)labelHeight pt:(int)pageType pageTotal:(int) total pageIndex:(int) index
{
    //labelWidth=70;
    //labelHeight=50;
    //bitmap=[UIImage imageNamed:@"test50.png"];
    //bitmap=[UIImage imageNamed:@"1.jpg"];
    //制作203dpi图片
    int realWidth = labelWidth * 8;
    int realHeight = labelHeight * 8;
    
    //图片宽度检查
    if(realWidth>bitmap.size.width)
    {
        realWidth=bitmap.size.width;
    }
    
    if(realHeight>bitmap.size.height)
    {
        realHeight=bitmap.size.height;
    }
    
    CGSize newSize=CGSizeMake(realWidth, realHeight);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    //UIGraphicsBeginImageContext(newSize);//根据当前大小创建一个基于位图图形的环境
    [bitmap drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];//根据新的尺寸画出传过来的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
    UIGraphicsEndImageContext();//关闭当前环境
    
    //[self saveImageToPhotos:newImage];
    
    NSData *cmd=[self bitmapRowToBytesArray:newImage pt:pageType pageTotal:total pageIndex:index];
    if(cmd==nil)
    {
        return false;
    }
    //NSLog(@"%@", cmd);
    //isBuffedWrite=false;
    [self printBin:cmd];
    return true;
}

- (int) toGray:(int) r green:(int) g blue:(int) b
{
    int sum = r * 19661 + g * 38666 + b * 7209;
    return sum >> 16 & 0xFF;
}

- (NSMutableArray*) pixelToByteArray:(uint32_t*)pixelData  rowWith:(int) useRowWith bitmap:(UIImage*) bitmap index:(int) row
{
    NSMutableArray *rowData=[[NSMutableArray alloc] initWithCapacity:0];
    // 从图片矩阵转换为byte数据
    int gray, sum = 0;
    for (int w = 0; w < useRowWith; w++) {
        //得到像素值 ARGB
        int seq=(row*(int)bitmap.size.width)+w;
        int pixel = pixelData[seq];
        
        int red = ((pixel & 0x00FF0000) >> 16);
        int green = ((pixel & 0x0000FF00) >> 8);
        int blue = (pixel & 0x000000FF);
        
        //取得灰度值
        gray =(int) (red * 0.3 + green * 0.59 + blue * 0.11);
        
        //if((gray>>2)<BayerPattern[row%8][w%8])
        if (gray <= 192)
        {
            sum |= 1 << (7 - w % 8);
        }
        
        if ((w + 1) % 8 == 0) {
            [rowData addObject:[NSNumber numberWithInt:sum]];
            sum = 0;
        }
    }
    //NSData *data=[NSKeyedArchiver archivedDataWithRootObject:rowData];
    return rowData;//[data bytes];
}

// 压缩
- (NSData*) bitmapRowToBytesArray:(UIImage*) bitmap pt:(int) pageType pageTotal:(int) pagesize pageIndex:(int) index
{
    //返回的结果数据
    NSMutableArray *data=[[NSMutableArray alloc] initWithCapacity:0];
    
    int MAX_WIDTH=48;
    // 压缩方法调用
    int rowWidth = bitmap.size.width;      // 图片宽度
    int useRowWith = (rowWidth >= MAX_WIDTH * 8) ? MAX_WIDTH * 8 : rowWidth;      // 这行有效宽度
    int rowOffset = (rowWidth >= MAX_WIDTH * 8) ? 0 : MAX_WIDTH - rowWidth / 8;   // 这行开始偏移量
    // ========================================= 得到图片的数据 ==================================
    int imageWidth = bitmap.size.width;
    int imageHeight = bitmap.size.height;
    
    
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), bitmap.CGImage);
    
    uint32_t *pixelData=rgbImageBuf;
    
    int spaceStart=0;
    int spaceEnd=0;
    int rowIndex=0;
    bool ispace=true;
    
    //NSMutableArray *arrs=[NSMutableArray new];

    //遍历每一行的数据
    for(;rowIndex<bitmap.size.height;rowIndex++)
    {
        NSMutableArray *cdata=[self convertData2:pixelData rwth:useRowWith image:bitmap index:rowIndex offset:rowOffset];
        
        //NSLog(@"%@",cdata);
        //[arrs addObject:cdata];
        
        
        if ((int)[cdata count]==2&&[[cdata objectAtIndex:0] intValue]==21)
        {
            //空白行
            if(ispace)
            {
                spaceStart=rowIndex;
                continue;
            }
        }
        else
        {
            ispace=false;
            spaceEnd=rowIndex;
        }
        
        for (id num in cdata) {
            [data addObject:num];
        }
    }
    
    // =================================== 返回结果 =============================================
    
    int nL, nH;
    int sL,sH;
    int bh = bitmap.size.height;
    int usePrint=bh-spaceStart-(bh-spaceEnd);
    
    nL = usePrint % 256;
    nH = usePrint / 256;
    sL = spaceStart % 256;
    sH = spaceStart /256;
    
    int fw=bitmap.size.width/8;
    
    int total=(int)[data count]-(bh-spaceEnd)*2+1+2;//空白占2个字节 18 指令 最后的00 占 1个字节 所以加上1;
    
    char b[4];
    b[3] =  (Byte) ((total>>24) & 0xFF);
    b[2] =  (Byte) ((total>>16) & 0xFF);
    b[1] =  (Byte) ((total>>8) & 0xFF);
    b[0] =  (Byte) (total & 0xFF);
    
    //初始化
    NSData *cmd=[self startPrintOrder:nL lenH:nH spaceLH:sL spaceNH:sH width:fw device:1 pcs:pagesize seq:index data1:b[0] data2:b[1] data3:b[2] data4:b[3]];
    const char *bytes = [cmd bytes];
    
    int len=total+(int)[cmd length];//增加一个结束指令 0x0C
    char post[len];
    int seq=0;
    //int cmdLen=(int)[cmd length];
    
    for (int i = 0; i < [cmd length]; i++)
    {
        post[seq]=bytes[i];
        seq=seq+1;
    }
    
    int numIndex=0;
    
    for(id num in data)
    {
        if(numIndex>total)
        {
            //NSLog(@"%d",numIndex);
            break;
        }
        //NSLog(@"%d",[num intValue]);
        numIndex++;
        post[seq]=[num intValue];
        seq=seq+1;
    }
    post[seq]=12;//结束指令 0x0C
    NSData *ndata=[NSData dataWithBytes:post length:seq+1];
    return ndata;
}

- (NSMutableArray*) convertData:(uint32_t*)pixelData rwth:(int)useRowWith image:(UIImage*)bitmap index:(int)rowIndex offset:(int)rowOffset
{
    // 得到图片每一行的数据 // 未压缩之前的图片
    NSMutableArray *rowData=[self pixelToByteArray:pixelData rowWith:useRowWith bitmap:bitmap index:rowIndex];
    return rowData;
}

- (NSMutableArray*) convertData2:(uint32_t*)pixelData rwth:(int)useRowWith image:(UIImage*)bitmap index:(int)rowIndex offset:(int)rowOffset
{
    NSMutableArray *data=[[NSMutableArray alloc] initWithCapacity:0];
    
    // 得到图片每一行的数据 // 未压缩之前的图片
    NSMutableArray *rowData=[self pixelToByteArray:pixelData rowWith:useRowWith bitmap:bitmap index:rowIndex];

    // ========================================= 判断是否全空行 =================================
    //NSLog(@"%@",rowData);
    
    int tail =(int) [rowData count] - 1;
    for (; tail >= 0; tail--) {
        int vl=[rowData[tail] intValue ];
        if (vl!= 0) break;
    }
    
    
    if (tail < 0) //return [NSData dataWithBytes:ORDER_ONE_LINE length:2];    // 空行指令
    {
        [data addObject:[NSNumber numberWithInt:0x15]];
        [data addObject:[NSNumber numberWithInt:0x01]];
        return data;
    }
    
    tail =(int) [rowData count];
    int front = 0;
    for (; front < tail; front++) {
        int ft=[rowData[front] intValue];
        if (ft != 0) break;
    }
    // [0,front-1] 是无用0 压缩
    // [tail+1,rowData.length-1] 是无用0 --- 直接可以发送00接送
    // ========================================= 把byte数据进行处理压缩 ==========================
    // 处理数据
    NSMutableArray *list=[[NSMutableArray alloc] initWithCapacity:0];
    if (rowOffset + front > 0) {
        RepeatCount *rc=[RepeatCount alloc];
        [rc init:@"0" second:[NSString stringWithFormat:@"%d",front+rowOffset]];
        [list addObject:rc];
    }
    
    int s = front, e = front + 1;
    for (; e < tail; e++) {    // 非0的数据
        int rs=[rowData[s] intValue];
        int re=[rowData[e] intValue];
        if (rs != re) {
            RepeatCount *rc=[RepeatCount alloc];
            [rc init:[NSString stringWithFormat:@"%d",[rowData[s] intValue]]
              second:[NSString stringWithFormat:@"%d",e - s]];
            [list addObject:rc];
            s = e;
        }
    }
    
    RepeatCount *rc=[RepeatCount alloc];
    [rc init:[NSString stringWithFormat:@"%d",[rowData[s] intValue]]
      second:[NSString stringWithFormat:@"%d",e - s]];
    [list addObject:rc];
    // ========================================= 处理上面的数据 ==================================
    [data addObject:[NSNumber numberWithInt:0x18]];
    // 处理list数据
    for (int i = 0; i < [list count]; ) {
        int d2=0;//大于1小于2的数据
        RepeatCount *rc=[list objectAtIndex:i];
        int ct=[rc.count intValue];
        if (ct >2) {
            [data addObject:[NSNumber numberWithInt:(ct | 0x80)]];
            [data addObject:[NSNumber numberWithInt:[rc.value intValue]]];
            i++;
        } else {
            if(ct==2)
            {
                d2=d2+1;
            }
            int lastOne;
            for (lastOne = i + 1; lastOne < [list count]; lastOne++) {
                RepeatCount *rc=[list objectAtIndex:lastOne];
                if ((int)rc.count > 2) {
                    break;
                }
                if((int)rc.count==2)
                {
                    d2=d2+1;
                }
            }
            [data addObject:[NSNumber numberWithInt:(lastOne - i + d2)]];    // 长度
            for (int j = i; j < lastOne; j++) {
                RepeatCount *rc=[list objectAtIndex:j];
                for(int k=0;k<[rc.count intValue];k++)
                {
                    [data addObject:[NSNumber numberWithInt:[rc.value intValue]]];
                }
            }
            i = lastOne;
        }
    }
    [data addObject:[NSNumber numberWithInt:(0x00)]]; // 结束头
    return data;
}

/**
 * 设置标签大小及缝隙定位方式指令
 *
 *            m=0： 表示本次打印完成后不定位缝隙
 *            <p/>
 *            m=1： 表示本次打印完成后自动定位缝隙
 *            <p/>
 *            表示本次打印的标签总长度为nL+nH*256个点
 *            <p/>
 *            表示本次打印的标签总长度为nL+nH*256个点
 *            <p/>
 *            表示打印浓度，取值范围：1~15，0表示不设置浓度，采用打印机默认浓度
 *            <p/>
 *            表示缝隙检测阈值，取值范围：1~33，0表示不设置阈值，采用打印机默认阈值
 *            <p/>
 */
- (NSData*) startPrintOrder:(int)nL lenH:(int)nH spaceLH:(int)sL spaceNH:(int)sH width:(int)fw device:(int) de pcs:(int) l1 seq:(int) l2 data1:(int) d1 data2:(int) d2 data3:(int) d3 data4:(int) d4;
{
    Byte data[]={0x17,nL,nH,sL,sH,fw,de,l1,l2,d1,d2,d3,d4};
    NSData *cmd=[[NSData alloc] initWithBytes:data length:13];
    return  cmd;
}

- (BOOL) drawLine:(int)start to:(int)end lh:(int)height
{
    if (start < 0 || end < 0 || height < 0)
        return false;
    if (start == end || height == 0) { // 不绘制
        return false;
    }
    if (start > end) {
        int temp = start;
        start = end;
        end = temp;
    }
    
    // 数据位
    int sL = start % 256;
    int sH = start / 256;
    int eL = end % 256;
    int eH = end / 256;
    
    Byte byte[]={0x1B,0x27,0x01,0x00,sL,sH,eL,eH,0x0D};
    NSData *cmd=[[NSData alloc] initWithBytes:byte length:9];
    return [self printBin:cmd];
}

- (BOOL) powerOff
{
    Byte byte[]={ 0x1B, 0xFF, 0x30, 0x00 };
    NSData *cmd=[[NSData alloc] initWithBytes:byte length:4];
    return [self printBin:cmd];
}

- (BOOL) onPrintDownPrinter:(int)n
{
    if (n < 0 || n > 7)
        return false;
    Byte data[] = { 0x1C, 0x50,  n };
    NSData *cmd=[[NSData alloc] initWithBytes:data length:3];
    return [self printBin:cmd];
}

- (BOOL) onDownImgIntoPrinter:(UIImage *)bitmap to:(int)position
{
    if (bitmap == nil)
        return false;
    if (position < 0 || position > 7)
        return false;
    // 获取宽度、高度和总像素
    int width = bitmap.size.width;
    int height = bitmap.size.height;
    
    // 使用的宽度和高度和总像素
    int useWidth = width / 8;
    int useHeight = height;
    int usePixelSum = useWidth * useHeight;
    
    // 发送图片数据
    Byte data[7 + usePixelSum]; // 3 + 4 + usePixelSum
    data[0] = 0x1B;
    data[1] =  0xFE;
    data[2] = position;
    data[3] = (useWidth % 256);
    data[4] = (useWidth / 256);
    data[5] = (useHeight % 256);
    data[6] = (useHeight / 256);
    
    char *pixelData = malloc( width * height );
    if(pixelData==nil) return false;
    CGContextRef context = CGBitmapContextCreate ( pixelData,
                                                  width,
                                                  height,
                                                  8,
                                                  width,
                                                  NULL,
                                                  kCGImageAlphaOnly );
    if(context==nil) return false;
    CGContextDrawImage( context, CGRectMake(0, 0, width, height), bitmap.CGImage );
    CGContextRelease( context );
    
    int index = 7;
    int gray, sum = 0;
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            gray = pixelData[(i*((int)width))+j];
            
            if (gray <= 192) {
                sum |= 1 << (7 - j % 8);
            }
            if ((j + 1) % 8 == 0) {
                data[index++] = sum;
                sum = 0;
            }
        }
    }
    NSData *cmd=[[NSData alloc] initWithBytes:data length:usePixelSum+7];
    return [self printBin:cmd];
}

@end
