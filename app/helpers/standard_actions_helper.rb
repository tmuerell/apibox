module StandardActionsHelper
    def _t(target)
      controller = params[:controller].singularize
      action = params[:action]
      t(:"actions.#{controller}.#{action}.#{target}", :default => [:"actions.#{controller}.#{target}", :"actions.#{target}" ])
    end
  
    def standard_actions(&block)
      content = capture(&block) if block_given?
  
      ret = ""
  
      model = params[:controller].singularize
  
  
      return if model =~ /^devise/i
      return if model =~ /^dashboard/i
      return if model =~ /^welcome/i
      return if model =~ /^whiteboard/i
      return if model =~ /^search/i
  
      iv = instance_variable_get("@#{model}")
      case params[:action]
      when "index"
        if can?(:create, model.classify.constantize)
          ret += link_to(_t("new"), {:action => :new}, :class => 'btn btn-primary')
          ret += " "
        end
      when "edit"
        if can? :read, iv
          ret += link_to(_t("show"), iv, :class => 'btn btn-light')
          ret += " "
          ret += link_to(_t("back"), {:action => :index}, :class => 'btn btn-light')
          ret += " "
        end
      when "new"
        if can? :read, iv
          ret += link_to(_t("back"), {:action => :index}, :class => 'btn btn-light')
          ret += " "
        end
      when "show"
        if can? :edit, iv
          ret += link_to(_t("edit"), {:action => :edit, :id => iv}, :class => 'btn btn-light')
          ret += " "
        end
        if can? :destroy, iv
          ret += link_to(_t("delete"), iv, data: { confirm: t('are_you_sure') }, :method => :delete, :class => 'btn btn-danger')
          ret += " "
        end
        if can? :read, iv
          ret += link_to(_t("back"), {:action => :index}, :class => 'btn btn-light')
          ret += " "
        end
      end
      ret += content if content
      ret.html_safe
    end
  
    def list_actions(v, icons = false)
      model = params[:controller].singularize
      ret = ""
  
      if can? :show, v
        ret += link_to(icons ? icon('show') : _t("show"), {:action => :show, :id => v}, :class => 'btn btn-sm btn-light')
        ret += " "
      end
      if can? :edit, v
        ret += link_to(icons ? icon('edit') : _t("edit"), {:action => :edit, :id => v}, :class => 'btn btn-sm btn-light')
        ret += " "
      end
      if can? :destroy, v
        ret += link_to(icons ? icon('trash') : _t("delete"), v, data: { confirm: t('are_you_sure') }, :method => :delete, :class => 'btn btn-sm btn-danger')
        ret += " "
      end
      ret.html_safe
    end
  end