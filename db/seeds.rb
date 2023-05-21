# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.all.each do |us|
  us.destroy
end
User.create!({first_name: "Админ", second_name: "Админов", patronymic: "Админович", email: "admin@gmail.ru", phone: "+79111111112", password: "password", password_confirmation: "password", role: 2})
Course.all.each do |cour|
  cour.destroy
end
Rating.all.each do |rat|
  rat.destroy
end
CoursesUser.all.each do |cu|
  cu.destroy
end
Lesson.all.each do |les|
  les.destroy
end
Test.all.each do |tes|
  tes.destroy
end
Rating.create({user_id: User.first.id, all_courses: 0, finished_courses: 0})
Course.create({                       	                                              	 
  title: "Психология безопасности: почему человек рискует",   
  description: "Разберетесь в причинах и последствиях несчастных случаев. Узнаете, из каким этапов состоит эволюция безопасности."})
@course = Course.first
@course.avatar.attach(io: File.open('app/assets/images/brain.jpg'), filename: 'brain.jpg')
Lesson.create({course_id: Course.first.id,
  number: 1,
  title: "Причины несчастных случаев",
  part_fr:
   "Почему люди травмируются  Большинство несчастных случаев происходят из-за опасного поведения работников. Намного реже приводят к травмам опасные условия на рабочих местах.  Когда люди нарушают требования охраны труда, они думают, что такое поведение не будет иметь последствий. Однако Герберт Хенрих изучал поведение работников и обнаружил связь между опасными действиями и несчастными случаями. Свои выводы он представил в виде пирамиды.",
  part_sc:
   "Исследования Хенриха показали, что одно из тридцати тысяч опасных действий приводит к смертельному исходу. Логично: если сотрудники не будут ошибаться и поступать необдуманно, несчастных случаев станет меньше. Но это тяжело донести до работников: большинство людей воспринимают предупреждение всерьез, если кто-то тяжело травмировался или умер. А пока этого не случилось, человек будет нарушать требования безопасности.",
  main: "Опасное поведение работников — причина большинства несчастных случаев.  Несчастных случаев станет меньше, если работники не будут ошибаться и поступать необдуманно."
})
@lesson = Lesson.first
@lesson.file.attach(io: File.open('app/assets/images/vid.mp4'), filename: 'vid.mp4')
@lesson.pictures.attach(io: File.open('app/assets/images/piramida.jpg'), filename: 'piramida.jpg')

Test.create(lesson_id: Lesson.first.id)
Question.create({              	 
  test_id: Test.first.id,
  num: 1,
  question: "Из-за чего происходит большинство несчастных случаев?",
  answer: "Из-за опасного поведения работников",
  wrong_first: "Из-за условий на работе",
  wrong_second: "Нет правильного ответа"})
  Question.create({
  test_id: Test.first.id,
  num: 2,
  question: "Кто изучал поведение работников и обнаружил связь между опасными действиями и несчастными случаями?",
  answer: "Герберт Хенрих",
  wrong_first: "Илон Маск",
  wrong_second: "Генри Форд"  })
  Question.create({
  test_id: Test.first.id,
  num: 3,
  question: "В виде какой диаграммы Гербер Хенрих представил свои исследования?",
  answer: "Пирамиды",
  wrong_first: "Ромб",
  wrong_second: "Граф"
  })
Question.create({
  test_id: Test.first.id,
  num: 4,
  question: "Несчастных случаев станет меньше, если",
  answer: "Работники не будут ошибаться и поступать необдуманно",
  wrong_first: "Улучшить рабочие условия",
  wrong_second: "Не знаю"})

