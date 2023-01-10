$onprem = @{
    BasePath = "https://intersight.com"
    ApiKeyId = "xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx"
    ApiKeyFilePath = "C:\\secretKey.txt"
    HttpSigningHeader =  @("(request-target)", "Host", "Date", "Digest")
}

Set-IntersightConfiguration @onprem

# use -SkipCertificateCheck to bypass the SSL certificate check. 

Get-IntersightConfiguration

BasePath                : https://intersight.com
ApiKeyId                : xxxxx27564612d30dxxxxx/5f21c9d97564612d30dd575a/5f9a8b877564612xxxxxxxx
ApiKeyFilePath          : C:\\secretKey.txt
ApiKeyPassPhrase        :
Proxy                   :
HashAlgorithm           : SHA256
HttpSigningHeader       : {"(request-target)", "Host", "Date", "Digest"}
SignatureValidityPeriod : 0