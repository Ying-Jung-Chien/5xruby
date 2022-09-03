module Admin::TasksHelper
    def id2name(id)
        User.find(id).name
    end
end
