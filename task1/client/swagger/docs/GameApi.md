# {{classname}}

All URIs are relative to *http://awesometabletop.ru/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GamesCreatePost**](GameApi.md#GamesCreatePost) | **Post** /games/create | Create a new game
[**GamesGetByUserUserIdGet**](GameApi.md#GamesGetByUserUserIdGet) | **Get** /games/getByUser/{userId} | Get games for user
[**GamesGetGameIdGet**](GameApi.md#GamesGetGameIdGet) | **Get** /games/get/{gameId} | Get game by its ID

# **GamesCreatePost**
> Game GamesCreatePost(ctx, optional)
Create a new game

Create a new game with current user as GM

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
 **optional** | ***GameApiGamesCreatePostOpts** | optional parameters | nil if no parameters

### Optional Parameters
Optional parameters are passed through a pointer to a GameApiGamesCreatePostOpts struct
Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**optional.Interface of Game**](Game.md)|  | 

### Return type

[**Game**](game.md)

### Authorization

[jwtAuth](../README.md#jwtAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **GamesGetByUserUserIdGet**
> InlineResponse2002 GamesGetByUserUserIdGet(ctx, userId)
Get games for user

Get the list of all games for current user

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
  **userId** | **int64**| User ID | 

### Return type

[**InlineResponse2002**](inline_response_200_2.md)

### Authorization

[jwtAuth](../README.md#jwtAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **GamesGetGameIdGet**
> Game GamesGetGameIdGet(ctx, gameId)
Get game by its ID

Get game by its ID in the database

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
  **gameId** | **int64**| Game ID | 

### Return type

[**Game**](game.md)

### Authorization

[jwtAuth](../README.md#jwtAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

