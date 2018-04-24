set.seed(71)
library(tidyverse)

# タイムスタンプをランダムに生成する関数
RandomTimeStamp <- function(M,
                            sDate = "2016/01/01",
                            eDate = "2016/12/31") {
  sDate <- as.POSIXct(as.Date(sDate))
  eDate <- as.POSIXct(as.Date(eDate))
  dTime <- as.numeric(difftime(eDate, sDate, unit="sec"))
  sTimeStamp <- sort(runif(M, 0, dTime))
  TimeStamp <- sDate + sTimeStamp
  return(TimeStamp)
}

# 全行数
N <- 1000000
# 人数
M <- 100000
# 商品数
P <- 10000

# 商品マスタデータ
ProductID <- c(1:P)
ProductName <- stringi::stri_rand_strings(n = P, length = 5)
Price <- sample(1000:10000, P, replace = T)
Category <- c("衣料品", "家具・インテリア・家電", "ヘルス＆ビューティー", "雑貨・日用品", "食品", "花・グリーン")
Product_Category <- sample(Category, P, replace = T)
Created <- sample(seq(as.Date("2000/01/01"), as.Date("2015/12/31"), by = "day"), P, replace = T)

product <- data.frame(
  ProductID = ProductID,
  ProductName = ProductName,
  Price = Price,
  Category = Product_Category,
  CreatedDate = Created
)

write_csv(product, "./csv/Products.csv")
write.csv(product,
          "./csv/Products_cp932.csv",
          row.names = FALSE,
          fileEncoding = "CP932")
write_tsv(product, "./tsv/Products.tsv")
openxlsx::write.xlsx(product, file = "./xlsx/Products.xlsx")

# 購買ログ
UserID <- stringi::stri_rand_strings(n = M, length = 20)
UserSale <- sample(UserID, N, replace = T)
ProductID2 <- sample(ProductID, N, replace = T)
TimeStamp <- RandomTimeStamp(N)

sales <- data.frame(
  UserID = UserSale,
  ProductID = ProductID2,
  Timestamp = TimeStamp
)

write_csv(sales, "./csv/Sales.csv")
write_tsv(sales, "./tsv/Sales.tsv")
openxlsx::write.xlsx(sales, file = "./xlsx/Sales.xlsx")

# ユーザーの属性情報
ages <- c(18:65)
age <- sample(ages, M, replace = T)

genders <- c("M", "F")
gender <- sample(genders, M, replace = T)

prefs <- jpndistrict::jpnprefs %>%
  mutate_at(vars(prefecture), funs(as.character)) %>%
  pull(prefecture)
pref <- sample(prefs, M, replace = T)

UserMaster <- data.frame(
  UserID = UserID,
  Age = age,
  Sex = gender,
  Pref = pref
)
write_csv(UserMaster, "./csv/UserMaster.csv")
