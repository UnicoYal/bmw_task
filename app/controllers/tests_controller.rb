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
      @flag = false
      $percent = ($count_right * 100)/($count_right+$count_wrong) #Процент НИКИТЕ
      if $percent > 60            #Проверка по проценту
        @flag = true   # Флаг никите
        @lesson_id = Test.find_by(lesson_id: params[:lesson_id]).lesson_id
        @course = Lesson.find_by(id: @lesson_id).course_id 
        pas = CoursesUser.find_by(user_id: current_user.id, course_id: @course) 
        if pas.finished_count < Lesson.where(course_id: @course).count
          counter = pas.finished_count
          pas.update(finished_count: counter+1)
        end
        if pas.finished_count == Lesson.where(course_id: @course).count 
          pas.update(status: true) 
        end
      end                               
    elsif request.post?
      $count_wrong = 0
      $count_right = 0 
      request_body = JSON.parse(request.body.read)
      $questions_hash = []
      $questions.each_with_index do |question, index|
        curr_hash = {}
        curr_hash[:question] = question
        if !(request_body.key?((index + 1).to_s))
          curr_hash[:correct] = false
          $count_wrong += 1
        elsif question.answer == request_body[question.num.to_s]
          curr_hash[:correct] = true
          $count_right += 1
        else
          curr_hash[:correct] = false
          $count_wrong += 1
        end
        $questions_hash.push(curr_hash)
      end
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
