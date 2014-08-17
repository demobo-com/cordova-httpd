#import "PhoneWebSocket.h"
#import "HTTPLogging.h"

// Log levels: off, error, warn, info, verbose
// Other flags : trace
static const int httpLogLevel = HTTP_LOG_LEVEL_WARN | HTTP_LOG_FLAG_TRACE;


@implementation PhoneWebSocket

- (void)didOpen
{
	HTTPLogTrace();
	
	[super didOpen];
	
	[self sendMessage:@"welcome"];
}

- (void)didReceiveMessage:(NSString *)msg
{
	HTTPLogTrace2(@"%@[%p]: didReceiveMessage: %@", THIS_FILE, self, msg);
    NSDictionary   *dict = [NSDictionary dictionaryWithObject: msg forKey: @"message"];
    // Notify HTTPServer
    //	[[NSNotificationCenter defaultCenter] postNotificationName:WebSocketBroadcastNotification object:self userInfo:dict];
    // Notify module
	[[NSNotificationCenter defaultCenter] postNotificationName:ReceiveMessageNotification object:self userInfo:dict];
}

- (void)didClose
{
	HTTPLogTrace();
	
	[super didClose];
}

@end
