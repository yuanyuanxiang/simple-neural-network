#https://yongyuan.name/blog/back-propagtion.html
input=matrix(c(0.05,0.10), nrow=2, ncol=1)
target=matrix(c(0.01,0.99), nrow=2, ncol=1)
A1=matrix(c(0.35,0.35,0.15,0.25,0.20,0.30), nrow=2, ncol=3)
A2=matrix(c(0.60,0.60,0.40,0.50,0.45,0.55), nrow=2, ncol=3)
Sigmoid <- function(m){
  r = m
  for (i in 1:length(r))
    r[i] = 1/(1 + exp(-r[i]))
  return (r)
}
# 训练
step = 10000

for (i in 1:step){
# 前向传播
middle = Sigmoid(A1 %*% rbind(1, input))
output = Sigmoid(A2 %*% rbind(1, middle))
cat("\nerr=", sqrt(norm(output-target)))
# 反向传播
diff = (output-target)*output*(1-output) * middle
cat("\nstep=", i); print(diff)
# 梯度下降
alpha = 0.5
B1=A1; B2=A2

B2[1, 2:3] = A2[1, 2:3] - alpha * diff[1]
B2[2, 2:3] = A2[2, 2:3] - alpha * diff[2]

s = (output-target)*output*(1-output)
B1[1, 2:3]=A1[1, 2:3] - alpha * (s[1] + s[2]) * A2[1, 2:3] * middle[1] * (1-middle[1]) * input[1]
B1[2, 2:3]=A1[2, 2:3] - alpha * (s[1] + s[2]) * A2[2, 2:3] * middle[2] * (1-middle[2]) * input[2]

A1=B1; A2=B2
}
