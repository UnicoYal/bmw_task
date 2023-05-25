class TestsController < ApplicationController
  def index
  end

  def show
    $id = params[:id]
    $course = Lesson.find_by_id($id).title
  end

  def questions_api
    $test = Test.find_by(lesson_id: params[:id])
    $questions = Question.where(test_id: $test.id).order("num asc")
    render json: $questions
  end

  def results_post
    if request.get?
      p $questions_hash
    elsif request.post?
      request_body = JSON.parse(request.body.read)
      $questions_hash = []
      $questions.each_with_index do |question, index|
        curr_hash = {}
        curr_hash[:question] = question
        if !(request_body.key?((index + 1).to_s))
          curr_hash[:correct] = false
        elsif question.answer == request_body[question.num.to_s]
          curr_hash[:correct] = true
        else
          curr_hash[:correct] = false
        end
        $questions_hash.push(curr_hash)
      end
    end
    # render 'tests/results_post'
    # p request_body
    # p $questions_hash  Тут твой массив хэшей
    # p 'CHECK'
    # p $questions_hash.first[:question].question Пример доступа к полю модели

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

  def edit
    @test = Test.find_by(lesson_id: params[:id])
    @testings = Question.where(test_id: @test.id).order("num asc")
  end

  def update
    @questions = Question.where(test_id: params[:id]).order("num asc")
    @count = @questions.count
    i = 0
    @questions.each do |el|
      el.update(question: params["question#{i}".to_s], answer: params["answer#{i}".to_s], wrong_first: params["wrong_first#{i}".to_s],
        wrong_second: params["wrong_second#{i}".to_s])
        i += 1
    end
    @test = Test.find_by(id: params[:id])
    @lesson = Lesson.find_by(id: @test.lesson_id)
    redirect_to "/lessons/show/#{@lesson.id}"
  end

end
