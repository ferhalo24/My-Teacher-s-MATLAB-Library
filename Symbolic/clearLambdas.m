function clearLambdas()

global lambda lambda_value n_lambda lambdaNames

for i=1:length(lambda)
evalin( 'base', "clear "+char(lambda(i)) ) 
end

lambda=sym(zeros(0,1));
lambda_value=zeros(0,1);
n_lambda=0;
lambdaNames=containers.Map();

end
