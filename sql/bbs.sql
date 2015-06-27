/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2015/6/26 20:14:30                           */
/*==============================================================*/

drop database if exists msgban;
create database msgban;
use msgban;

drop table if exists Status;

drop table if exists User;

drop table if exists comment;

drop table if exists friends;

drop table if exists status_notice;

/*==============================================================*/
/* Table: Status                                                */
/*==============================================================*/
create table Status
(
   id                   int not null auto_increment,
   user_id              int,
   create_time          datetime default CURRENT_TIMESTAMP,
   views                int default 0,
   content              varchar(500) not null,
   praises              int,
   friend_id            int,
   primary key (id)
);

/*==============================================================*/
/* Table: User                                                  */
/*==============================================================*/
create table User
(
   id                   int not null auto_increment,
   name                 varbinary(20) not null,
   email                varchar(30) not null,
   password             varchar(20) not null,
   imgSrc               varchar(20),
   late_online          datetime default CURRENT_TIMESTAMP,
   primary key (id)
);

/*==============================================================*/
/* Table: comment                                               */
/*==============================================================*/
create table comment
(
   id                   int not null auto_increment,
   status_id            int,
   comment_id           int,
   user_id              int,
   content              varchar(200) not null,
   comment_time         datetime default CURRENT_TIMESTAMP,
    p_user_id            int,
   primary key (id)
);

/*==============================================================*/
/* Table: friends                                               */
/*==============================================================*/
create table friends
(
   user_Id              int not null,
   friend_id            int not null,
   primary key (user_Id, friend_id)
);

/*==============================================================*/
/* Table: status_notice                                         */
/*==============================================================*/
create table status_notice
(
   user_id              int not null,
   notice_id            int not null,
   isMsg                boolean default false,
   register_time        datetime default CURRENT_TIMESTAMP,
   primary key (user_id, notice_id)
);

alter table Status add constraint FK_Relationship_4 foreign key (user_id)
      references User (id) on delete restrict on update restrict;

alter table comment add constraint FK_Relationship_1 foreign key (status_id)
      references Status (id) on delete restrict on update restrict;

alter table comment add constraint FK_Relationship_3 foreign key (user_id)
      references User (id) on delete restrict on update restrict;

#alter table comment add constraint FK_Relationship_8 foreign key (comment_id)
#      references comment (id) on delete restrict on update restrict;

alter table friends add constraint FK_Relationship_6 foreign key (user_Id)
      references User (id) on delete restrict on update restrict;

alter table friends add constraint FK_Relationship_7 foreign key (friend_id)
      references User (id) on delete restrict on update restrict;

alter table status_notice add constraint FK_Reference_10 foreign key (notice_id)
      references Status (id) on delete restrict on update restrict;

alter table status_notice add constraint FK_Reference_7 foreign key (user_id)
      references User (id) on delete restrict on update restrict;
