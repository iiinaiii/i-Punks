# i-Punks

Sample repository for learning iOS MVVM pattern.

# Architecture overview
## MVVM + Layerd architecture
<img src="https://user-images.githubusercontent.com/16633277/60384005-dd0dbf80-9ab3-11e9-940b-2c90a5427617.png" width="480px">

### MVVM
* Same as common MVVM, it divides the responsibilities into View/ViewModel/Model

### Layered architecture
* Model layer is divided into three, UseCase/Domain/Infra, according to each responsibility.

### Rx
* RxSwift is used to expose data in the `Model` layer
* RxCocoa is used to pass data from `ViewModel` to `View`

### DI
* Each layer instance is injected by DI framework (Swinject https://github.com/Swinject/Swinject)
