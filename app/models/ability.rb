class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.role? :volunteer
        can :read, [Event, Job, User]
        can :manage, Task, :job => { :user_id => user.id }
      end
      if user.role? :admin
        can :manage, [Event, Job]
      end
      if user.role? :superadmin
        can :manage, :all
      end
    end
  end
end
