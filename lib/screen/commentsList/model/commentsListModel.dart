class CommentsListModel {
  List<Data> data;
  int count;
  int status;

  CommentsListModel({this.data, this.count, this.status});

  CommentsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    count = json['count'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String commentId;
  String id;
  String userId;
  String hospitalId;
  String comment;
  String categoryId;
  String subcategoryId;
  String upvotes;
  String downvotes;
  Null tags;
  String parentId;
  String createdAt;
  String updatedAt;
  String name;
  String email;
  Null password;
  String type;
  String phone;
  String profilePic;
  String deviceId;
  String categoryName;
  String subcategoryName;
  List<TagsUsed> tagsUsed;
  List<UserVote> userVote;
  List<CommentReply> commentReply;

  Data(
      {this.commentId,
        this.id,
        this.userId,
        this.hospitalId,
        this.comment,
        this.categoryId,
        this.subcategoryId,
        this.upvotes,
        this.downvotes,
        this.tags,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.email,
        this.password,
        this.type,
        this.phone,
        this.profilePic,
        this.deviceId,
        this.categoryName,
        this.subcategoryName,
        this.tagsUsed,
        this.userVote,
        this.commentReply});

  Data.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    id = json['id'];
    userId = json['user_id'];
    hospitalId = json['hospital_id'];
    comment = json['comment'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    tags = json['tags'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    type = json['type'];
    phone = json['phone'];
    profilePic = json['profile_pic'];
    deviceId = json['device_id'];
    categoryName = json['category_name'];
    subcategoryName = json['subcategory_name'];
    if (json['tags_used'] != null) {
      tagsUsed = new List<TagsUsed>();
      json['tags_used'].forEach((v) {
        tagsUsed.add(new TagsUsed.fromJson(v));
      });
    }
    if (json['user_vote'] != null) {
      userVote = new List<UserVote>();
      json['user_vote'].forEach((v) {
        userVote.add(new UserVote.fromJson(v));
      });
    }
    if (json['comment_reply'] != null) {
      commentReply = new List<CommentReply>();
      json['comment_reply'].forEach((v) {
        commentReply.add(new CommentReply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['hospital_id'] = this.hospitalId;
    data['comment'] = this.comment;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['upvotes'] = this.upvotes;
    data['downvotes'] = this.downvotes;
    data['tags'] = this.tags;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['type'] = this.type;
    data['phone'] = this.phone;
    data['profile_pic'] = this.profilePic;
    data['device_id'] = this.deviceId;
    data['category_name'] = this.categoryName;
    data['subcategory_name'] = this.subcategoryName;
    if (this.tagsUsed != null) {
      data['tags_used'] = this.tagsUsed.map((v) => v.toJson()).toList();
    }
    if (this.userVote != null) {
      data['user_vote'] = this.userVote.map((v) => v.toJson()).toList();
    }
    if (this.commentReply != null) {
      data['comment_reply'] = this.commentReply.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TagsUsed {
  String name;

  TagsUsed({this.name});

  TagsUsed.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class UserVote {
  String trackVoteId;
  String userId;
  String commentId;
  String voteType;
  String createdAt;
  String updatedAt;

  UserVote(
      {this.trackVoteId,
        this.userId,
        this.commentId,
        this.voteType,
        this.createdAt,
        this.updatedAt});

  UserVote.fromJson(Map<String, dynamic> json) {
    trackVoteId = json['track_vote_id'];
    userId = json['user_id'];
    commentId = json['comment_id'];
    voteType = json['vote_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['track_vote_id'] = this.trackVoteId;
    data['user_id'] = this.userId;
    data['comment_id'] = this.commentId;
    data['vote_type'] = this.voteType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CommentReply {
  String commentId;
  String id;
  String userId;
  String hospitalId;
  String comment;
  String categoryId;
  String subcategoryId;
  String upvotes;
  String downvotes;
  Null tags;
  String parentId;
  String createdAt;
  String updatedAt;
  String name;
  String email;
  Null password;
  String type;
  String phone;
  String profilePic;
  String deviceId;

  CommentReply(
      {this.commentId,
        this.id,
        this.userId,
        this.hospitalId,
        this.comment,
        this.categoryId,
        this.subcategoryId,
        this.upvotes,
        this.downvotes,
        this.tags,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.email,
        this.password,
        this.type,
        this.phone,
        this.profilePic,
        this.deviceId});

  CommentReply.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    id = json['id'];
    userId = json['user_id'];
    hospitalId = json['hospital_id'];
    comment = json['comment'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    tags = json['tags'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    type = json['type'];
    phone = json['phone'];
    profilePic = json['profile_pic'];
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['hospital_id'] = this.hospitalId;
    data['comment'] = this.comment;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['upvotes'] = this.upvotes;
    data['downvotes'] = this.downvotes;
    data['tags'] = this.tags;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['type'] = this.type;
    data['phone'] = this.phone;
    data['profile_pic'] = this.profilePic;
    data['device_id'] = this.deviceId;
    return data;
  }
}
