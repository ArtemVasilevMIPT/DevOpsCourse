# {{classname}}

All URIs are relative to *http://awesometabletop.ru/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**TokenAccessPost**](JWTApi.md#TokenAccessPost) | **Post** /token/access | Refresh token

# **TokenAccessPost**
> InlineResponse200 TokenAccessPost(ctx, optional)
Refresh token

Takes a refresh type JSON web token and returns an access type JSON web token if the refresh token is valid.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
 **optional** | ***JWTApiTokenAccessPostOpts** | optional parameters | nil if no parameters

### Optional Parameters
Optional parameters are passed through a pointer to a JWTApiTokenAccessPostOpts struct
Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**optional.Interface of TokenAccessBody**](TokenAccessBody.md)|  | 

### Return type

[**InlineResponse200**](inline_response_200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

