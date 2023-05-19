class TestsController < ApplicationController
  def index
  end

  def show
    $test = Test.find_by(lesson_id: params[:id])
    $questions = Question.where(test_id: $test.id).order("num asc")
  end

  def ans
    @correct = []
    @incorrect = []
    @your_ans = []
    $questions.each do |el| 
      if params["ans#{el.num}".to_s] == el.answer
        @correct.push(el.num)
      else
        @incorrect.push(el.num)
      end
      @your_ans.push(params["ans#{el.num}".to_s])
    end
  end
end
