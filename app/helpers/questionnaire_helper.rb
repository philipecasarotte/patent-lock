module QuestionnaireHelper
  def progress_bar question
    percent = (question / (Question.all.size.to_f + 2)) * 100
    percent.to_i
  end
  
  def add_object_link(name, object, partial, where)
      html = render(:partial => partial, :object => object)
      link_to_function name, %{
        var new_object_id = new Date().getTime() ;
        var html = jQuery(#{js html}.replace(/index_to_replace_with_js/g, new_object_id)).hide();
        html.appendTo(jQuery("#{where}")).slideDown('slow');
      }
  end
  
  def js(data)
    if data.respond_to? :to_json
      data.to_json
    else
      data.inspect.to_json
    end
  end
end
