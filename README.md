#Yamaha - Manual SDK iOS Testing App

> **Note**  
> Segment has paused maintenance on this project, but may return it to an active status in the future. Issues and pull requests from external contributors are not being considered, although internal contributions may appear from time to time. The project remains available under its open source license for anyone to use.

The Yamaha testing app is setup with the Segment SDK with the following parameters:

1. Use the `ios-objectivec-example`  source write key [here](https://segment.com/segment-mobile/sources/ios/settings/keys)
2. Lifecycle tracking is enabled
3. Bundle the Mixpanel client side integration
4. DO NOT bundle the Amplitude client side integration

The `yamaha` source has the following settings:

1. Amplitude integration enabled
  1. https://segment.com/segment-mobile/sources/ios/integrations/amplitude
2. Mixpanel integration enabled
  1. https://segment.com/segment-mobile/sources/ios/integrations/mixpanel
3. Event `Event ``2` is disabled in the schema


##Layout

The Yamaha testing app has a single screen with the following buttons:

|Button   | Action  |
|---|---|
|Flush| `[[SEGAnalytics sharedAnalytics] flush]` |
|Event 1| `[[SEGAnalytics sharedAnalytics] track:@"Event 1"]` |
|Event 2| `[[SEGAnalytics sharedAnalytics] track:@"Event 2"]` |
|Event 3| `[[SEGAnalytics sharedAnalytics] track:@"Event 3"]` |
|Identify| `[[SEGAnalytics sharedAnalytics] identify:@"Yamaha Star V Star 250"]` |
|Offline Test| `[[SEGAnalytics sharedAnalytics] track:@"Offline Test"]` |
|Reset| `[[SEGAnalytics sharedAnalytics] reset]`|
|Group| `[[SEGAnalytics sharedAnalytics] group:@"Yamaha Motor Sports Co"];` |
|Alias| `[[SEGAnalytics sharedAnalytics] alias:@"V STAR 1300 DELUXE"];` |
