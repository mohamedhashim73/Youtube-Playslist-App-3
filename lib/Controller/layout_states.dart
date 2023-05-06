abstract class LayoutStates{}

class LayoutInitialState extends LayoutStates{}
class FilteredUsersSuccessState extends LayoutStates{}
class SendMessageSuccessState extends LayoutStates{}
class ChangeSearchStatusSuccessState extends LayoutStates{}

class GetMyDataSuccessState extends LayoutStates{}
class FailedToGetMyDataState extends LayoutStates{}

class GetUsersDataSuccessState extends LayoutStates{}
class GetUsersLoadingState extends LayoutStates{}
class FailedToGetUsersDataState extends LayoutStates{}
class GetMessagesSuccessState extends LayoutStates{}
class GetMessagesFailureState extends LayoutStates{}
class GetMessagesLoadingState extends LayoutStates{}
