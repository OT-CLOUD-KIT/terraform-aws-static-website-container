bucket_name             = "static-site-bucket"
aliases                 = []
force_destroy           = true
ssl_certificate_arn     = ""
allowed_ips             = []
web_acl_id              = ""
refer_secret            = "custom-user-agent"
cloudfront_price_class  = "PriceClass_100"
index_document          = "index.html"
error_document          = "error.html"
error_response_code     = "404"
spa_error_response_code = "200"



random_alphanumeric_len = 4

bu       = "ot"
app      = "bp"
env      = "d"
resource = "static_container"
tenant   = ""

special = false
upper   = false
number  = true

gen_no_of_names = 1

team    = "infra"
program = "ot"
