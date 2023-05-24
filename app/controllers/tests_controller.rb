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

  def create
    @test = Test.create(lesson_id: params[:id])
    $count.times do |i| 
      Question.create(test_id: @test.id, num: i+1, question: params["question#{i}".to_s], answer: params["answer#{i}".to_s], wrong_first: params["wrong_first#{i}".to_s],
      wrong_second: params["wrong_second#{i}".to_s])
    end
    redirect_to show_les_path
  end

  def select_num
    @lesson = Lesson.find_by(id: params[:id])
  end

  def create_questions
    @lesson = Lesson.find_by(id: params[:id])
    $count = params[:count].to_i
  end

  def destroy
    Test.find_by(lesson_id: params[:id]).destroy
    redirect_to show_les_path
  end

end
