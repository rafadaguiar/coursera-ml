function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
a1 = [ones(m,1) X];
z2 = a1*Theta1';
h2 = sigmoid(z2);
a2 = [ones(size(h2,1),1)  h2];
z3 = a2*Theta2';
h3 = sigmoid(z3);
a3 = h3;
ho = a3;

%----------------------%
% binaryHo = zeros(size(ho));
% for i = 1:m 
%     [k,j] = max(ho(i,:));
%     binaryHo(i,j) = 1;
% end
binaryY = zeros(size(ho));
for i = 1:m 
    binaryY(i,:) = zeros(1,size(ho,2));
    binaryY(i,y(i)) = 1;  
end  
%----------------------%

%Unregularized Cost Function
% for j = 1:size(ho,2) 
%     J += (1/m)*(-log(ho(:,j))'*binaryY(:,j) - log(1-ho(:,j))'*(1-binaryY(:,j)));
% end


%Regularized Cost Function
o1 = Theta1(:,2:end);
o2 = Theta2(:,2:end);

r = (sum(sum(o1.^2)) + sum(sum(o2.^2)));
regularization = (lambda/(2*m))*(r);

for j = 1:size(ho,2) 
    J += (1/m)*(-log(ho(:,j))'*binaryY(:,j) - log(1-ho(:,j))'*(1-binaryY(:,j)));
end
J+=regularization;



%BackPropagation
error3 = ho-binaryY;
g = sigmoidGradient(z2);
error2 = ((error3*Theta2).*[ones(size(g,1),1) g])(:,2:end);
delta2 = error3'*a2;
delta1 = error2'*a1;
Theta1_grad += (1/m)*delta1;
Theta2_grad += (1/m)*delta2;

%Regularization
Theta1_grad += [Theta1(:,1) (lambda/m)*o1];
Theta2_grad += [Theta2(:,1) (lambda/m)*o2];

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
