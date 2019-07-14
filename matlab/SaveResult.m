function loss = SaveResult(A1, A2, Loss, errs, iter, n)
%% 更新网络权重和残差.
% A1,A2：网络权重.
% Loss:上一次误差和精度
% errs:误差和精度
% iter:迭代次数
% 保存格式为"Matrix_s000001.mat".

step = iter + size(Loss, 2);
loss = Loss;
Loss = [Loss, errs(:, 1:iter)];
if 0 == mod(iter, n)
    save(['Matrix1_s', num2str(step, '%06d'), '.mat'], 'A1');
    save(['Matrix2_s', num2str(step, '%06d'), '.mat'], 'A2');
    save('Loss.mat', 'Loss');
end
%% 绘制
figure(1);
subplot(1, 2, 1);
plot(Loss(1, :));
title('loss');
figure(1);
subplot(1, 2, 2);
plot(Loss(2, :), '-r+');
hold on;
plot(Loss(3, :), '-b*');
title('acc');
legend('train', 'test');
pause(1);
end
