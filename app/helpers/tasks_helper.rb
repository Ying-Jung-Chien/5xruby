module TasksHelper
  def next_dir
    if params[:dir]
      params[:dir] == 'asc' ? 'desc' : 'asc'
    else
      params[:dir] = 'desc'
    end
  end

  def priority2text(value)
    priority = [I18n.t("low"), I18n.t("medium"), I18n.t("high")]
      priority[value]
  end

  def status2text(value)
    status = [I18n.t("solved"), I18n.t("processing"), I18n.t("pending")]
      status[value]
  end
end
