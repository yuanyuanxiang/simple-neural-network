#https://yongyuan.name/blog/back-propagtion.html
# 输入、输出值
input=matrix(c(0.05,0.10), nrow=2, ncol=1)
target=matrix(c(0.01,0.99), nrow=2, ncol=1)
# 初始权重
A1=matrix(c(0.35,0.35,0.15,0.25,0.20,0.30), nrow=2, ncol=3)
A2=matrix(c(0.60,0.60,0.40,0.50,0.45,0.55), nrow=2, ncol=3)

# 激活函数-Sigmoid函数
Sigmoid <- function(m){
  r = m
  for (i in 1:length(r))
    r[i] = 1/(1 + exp(-r[i]))
  return (r)
}
S_grad <- function(x){
  return (x * (1-x))
}
# 激活函数-线性整流函数
ReLU <- function(m){
  r = m
  for (i in 1:length(r))
  {
    if (r[i] < 0)
      r[i] = 0
  }
  return (r)
}
R_grad <- function(x){
  return (ifelse(x <= 0, 0, 1))
}
# 训练参数
step = 1000 #步数
fx = ReLU 	#激活函数
df = R_grad #激活函数导数

###############################################
for (i in 1:step){
# 前向传播
middle = fx(A1 %*% rbind(1, input))
output = fx(A2 %*% rbind(1, middle))
err = output - target
cat("\nerr=", norm(err, "2"), "\n")

# 反向传播

# 梯度下降
alpha = 0.5
B1=A1; B2=A2

# 倒数第一层
err1 = err
diff = (err1 * df(output)) %*% t(middle)
B2[, 2:3] = A2[, 2:3] - alpha * diff

# 倒数第二层
err2 = t(B2[, 2:3]) %*% err1
diff = (err2 * df(middle)) %*% t(input)
B1[, 2:3] = A1[, 2:3] - alpha * diff

A1=B1; A2=B2
}
###############################################
# 预测函数
predicate <- function(x0){
  x1 = fx(A1 %*% rbind(1, x0))
  x2 = fx(A2 %*% rbind(1, x1))
  return (x2)
}
