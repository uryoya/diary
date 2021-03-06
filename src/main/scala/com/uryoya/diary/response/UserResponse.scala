package com.uryoya.diary.response

import com.uryoya.diary.entity.UserId
import com.uryoya.diary.entity.mysql._

final case class UserResponse(
  id: UserId,
  login: String,
  name: String,
  avatarUri: String,
  admin: Boolean,
)

object UserResponse {
  def fromUserEntity(user: User): UserResponse =
    UserResponse(user.id, user.login, user.name, user.avatarUri, user.admin)

  def fromUserEntity(user: AboutUser): UserResponse =
    UserResponse(user.id, user.login, user.name, user.avatarUri, user.admin)
}
