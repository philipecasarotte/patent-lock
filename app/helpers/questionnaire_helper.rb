module QuestionnaireHelper
  def progress_bar question
    percent = (question / (Question.all.size.to_f + 2)) * 100
    percent.to_i
  end
end
