class UserDataResponseModel {
  bool? success;
  Data? data;
  String? msg;

  UserDataResponseModel({this.success, this.data, this.msg});

  UserDataResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  String? access;
  Meeting? meeting;
  String? conferenceUrl;
  Config? config;
  String? code;

  Data({this.access, this.meeting, this.conferenceUrl, this.config, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    meeting =
    json['meeting'] != null ? new Meeting.fromJson(json['meeting']) : null;
    conferenceUrl = json['conference_url'];
    config =
    json['config'] != null ? new Config.fromJson(json['config']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access'] = this.access;
    if (this.meeting != null) {
      data['meeting'] = this.meeting!.toJson();
    }
    data['conference_url'] = this.conferenceUrl;
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Meeting {
  String? name;
  String? mId;
  String? startDate;
  String? startTime;
  Null? uid;
  String? email;
  String? meetingType;
  Null? passcode;
  int? createdBy;
  String? altHost;
  String? participantId;
  String? isPresenter;
  int? meetParticipantUponEnter;
  int? passwordRequired;
  int? videoHost;
  int? videoParticipant;
  int? enableJoinBeforeHost;
  int? enableWaitingRoom;
  int? recordMeetAutoOnLocal;
  int? isRecurring;
  int? registrationRequired;
  int? qaRequired;
  int? approval;
  int? notifyParticipantRegister;
  int? closeRegAfterEvent;
  int? restrictNoOfReg;
  int? allowToJoinFromMultipleDevices;
  int? showSocialShareBtnOnRegPage;
  int? restrictGuestUser;
  int? allowedIntervals;
  int? maxRegister;
  int? enableInterpretation;
  int? registerOption;
  int? mailNotified;
  Flags? flags;

  Meeting(
      {this.name,
        this.mId,
        this.startDate,
        this.startTime,
        this.uid,
        this.email,
        this.meetingType,
        this.passcode,
        this.createdBy,
        this.altHost,
        this.participantId,
        this.isPresenter,
        this.meetParticipantUponEnter,
        this.passwordRequired,
        this.videoHost,
        this.videoParticipant,
        this.enableJoinBeforeHost,
        this.enableWaitingRoom,
        this.recordMeetAutoOnLocal,
        this.isRecurring,
        this.registrationRequired,
        this.qaRequired,
        this.approval,
        this.notifyParticipantRegister,
        this.closeRegAfterEvent,
        this.restrictNoOfReg,
        this.allowToJoinFromMultipleDevices,
        this.showSocialShareBtnOnRegPage,
        this.restrictGuestUser,
        this.allowedIntervals,
        this.maxRegister,
        this.enableInterpretation,
        this.registerOption,
        this.mailNotified,
        this.flags});

  Meeting.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mId = json['m_id'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    uid = json['uid'];
    email = json['email'];
    meetingType = json['meeting_type'];
    passcode = json['passcode'];
    createdBy = json['created_by'];
    altHost = json['alt_host'];
    participantId = json['participant_id'];
    isPresenter = json['is_presenter'];
    meetParticipantUponEnter = json['meet_participant_upon_enter'];
    passwordRequired = json['password_required'];
    videoHost = json['video_host'];
    videoParticipant = json['video_participant'];
    enableJoinBeforeHost = json['enable_join_before_host'];
    enableWaitingRoom = json['enable_waiting_room'];
    recordMeetAutoOnLocal = json['record_meet_auto_on_local'];
    isRecurring = json['is_recurring'];
    registrationRequired = json['registration_required'];
    qaRequired = json['qa_required'];
    approval = json['approval'];
    notifyParticipantRegister = json['notify_participant_register'];
    closeRegAfterEvent = json['close_reg_after_event'];
    restrictNoOfReg = json['restrict_no_of_reg'];
    allowToJoinFromMultipleDevices =
    json['allow_to_join_from_multiple_devices'];
    showSocialShareBtnOnRegPage = json['show_social_share_btn_on_reg_page'];
    restrictGuestUser = json['restrict_guest_user'];
    allowedIntervals = json['allowed_intervals'];
    maxRegister = json['max_register'];
    enableInterpretation = json['enable_interpretation'];
    registerOption = json['register_option'];
    mailNotified = json['mail_notified'];
    flags = json['flags'] != null ? new Flags.fromJson(json['flags']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['m_id'] = this.mId;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['meeting_type'] = this.meetingType;
    data['passcode'] = this.passcode;
    data['created_by'] = this.createdBy;
    data['alt_host'] = this.altHost;
    data['participant_id'] = this.participantId;
    data['is_presenter'] = this.isPresenter;
    data['meet_participant_upon_enter'] = this.meetParticipantUponEnter;
    data['password_required'] = this.passwordRequired;
    data['video_host'] = this.videoHost;
    data['video_participant'] = this.videoParticipant;
    data['enable_join_before_host'] = this.enableJoinBeforeHost;
    data['enable_waiting_room'] = this.enableWaitingRoom;
    data['record_meet_auto_on_local'] = this.recordMeetAutoOnLocal;
    data['is_recurring'] = this.isRecurring;
    data['registration_required'] = this.registrationRequired;
    data['qa_required'] = this.qaRequired;
    data['approval'] = this.approval;
    data['notify_participant_register'] = this.notifyParticipantRegister;
    data['close_reg_after_event'] = this.closeRegAfterEvent;
    data['restrict_no_of_reg'] = this.restrictNoOfReg;
    data['allow_to_join_from_multiple_devices'] =
        this.allowToJoinFromMultipleDevices;
    data['show_social_share_btn_on_reg_page'] =
        this.showSocialShareBtnOnRegPage;
    data['restrict_guest_user'] = this.restrictGuestUser;
    data['allowed_intervals'] = this.allowedIntervals;
    data['max_register'] = this.maxRegister;
    data['enable_interpretation'] = this.enableInterpretation;
    data['register_option'] = this.registerOption;
    data['mail_notified'] = this.mailNotified;
    if (this.flags != null) {
      data['flags'] = this.flags!.toJson();
    }
    return data;
  }
}

class Flags {
  int? id;
  String? meetingId;
  int? passwordRequired;
  int? videoHost;
  int? videoParticipant;
  int? enableJoinBeforeHost;
  int? muteParticipantUponEnter;
  int? enableWaitingRoom;
  int? recordMeetAutoOnLocal;
  int? isRecurring;
  int? registrationRequired;
  int? qaRequired;
  int? approval;
  int? notifyParticipantRegister;
  int? closeRegAfterEvent;
  int? restrictNoOfReg;
  int? allowToJoinFromMultipleDevices;
  int? showSocialShareBtnOnRegPage;
  int? restrictGuestUser;
  int? enableInterpretation;
  int? registerOption;
  int? mailNotified;
  int? allowedIntervals;
  int? maxRegister;
  int? whiteboardEnabled;
  int? whiteBoardLock;
  bool? readUrl;
  String? writeUrl;
  Null? webinarHost;
  int? hostLeft;
  int? restrictedMode;
  String? docVerify;
  int? docverifyEnabled;
  int? documentGuestEnabled;
  int? createdBy;

  Flags(
      {this.id,
        this.meetingId,
        this.passwordRequired,
        this.videoHost,
        this.videoParticipant,
        this.enableJoinBeforeHost,
        this.muteParticipantUponEnter,
        this.enableWaitingRoom,
        this.recordMeetAutoOnLocal,
        this.isRecurring,
        this.registrationRequired,
        this.qaRequired,
        this.approval,
        this.notifyParticipantRegister,
        this.closeRegAfterEvent,
        this.restrictNoOfReg,
        this.allowToJoinFromMultipleDevices,
        this.showSocialShareBtnOnRegPage,
        this.restrictGuestUser,
        this.enableInterpretation,
        this.registerOption,
        this.mailNotified,
        this.allowedIntervals,
        this.maxRegister,
        this.whiteboardEnabled,
        this.whiteBoardLock,
        this.readUrl,
        this.writeUrl,
        this.webinarHost,
        this.hostLeft,
        this.restrictedMode,
        this.docVerify,
        this.docverifyEnabled,
        this.documentGuestEnabled,
        this.createdBy});

  Flags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetingId = json['meeting_id'];
    passwordRequired = json['password_required'];
    videoHost = json['video_host'];
    videoParticipant = json['video_participant'];
    enableJoinBeforeHost = json['enable_join_before_host'];
    muteParticipantUponEnter = json['mute_participant_upon_enter'];
    enableWaitingRoom = json['enable_waiting_room'];
    recordMeetAutoOnLocal = json['record_meet_auto_on_local'];
    isRecurring = json['is_recurring'];
    registrationRequired = json['registration_required'];
    qaRequired = json['qa_required'];
    approval = json['approval'];
    notifyParticipantRegister = json['notify_participant_register'];
    closeRegAfterEvent = json['close_reg_after_event'];
    restrictNoOfReg = json['restrict_no_of_reg'];
    allowToJoinFromMultipleDevices =
    json['allow_to_join_from_multiple_devices'];
    showSocialShareBtnOnRegPage = json['show_social_share_btn_on_reg_page'];
    restrictGuestUser = json['restrict_guest_user'];
    enableInterpretation = json['enable_interpretation'];
    registerOption = json['register_option'];
    mailNotified = json['mail_notified'];
    allowedIntervals = json['allowed_intervals'];
    maxRegister = json['max_register'];
    whiteboardEnabled = json['whiteboard_enabled'];
    whiteBoardLock = json['white_board_lock'];
    readUrl = json['read_url'];
    writeUrl = json['write_url'];
    webinarHost = json['webinar_host'];
    hostLeft = json['host_left'];
    restrictedMode = json['restricted_mode'];
    docVerify = json['doc_verify'];
    docverifyEnabled = json['docverify_enabled'];
    documentGuestEnabled = json['document_guest_enabled'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meeting_id'] = this.meetingId;
    data['password_required'] = this.passwordRequired;
    data['video_host'] = this.videoHost;
    data['video_participant'] = this.videoParticipant;
    data['enable_join_before_host'] = this.enableJoinBeforeHost;
    data['mute_participant_upon_enter'] = this.muteParticipantUponEnter;
    data['enable_waiting_room'] = this.enableWaitingRoom;
    data['record_meet_auto_on_local'] = this.recordMeetAutoOnLocal;
    data['is_recurring'] = this.isRecurring;
    data['registration_required'] = this.registrationRequired;
    data['qa_required'] = this.qaRequired;
    data['approval'] = this.approval;
    data['notify_participant_register'] = this.notifyParticipantRegister;
    data['close_reg_after_event'] = this.closeRegAfterEvent;
    data['restrict_no_of_reg'] = this.restrictNoOfReg;
    data['allow_to_join_from_multiple_devices'] =
        this.allowToJoinFromMultipleDevices;
    data['show_social_share_btn_on_reg_page'] =
        this.showSocialShareBtnOnRegPage;
    data['restrict_guest_user'] = this.restrictGuestUser;
    data['enable_interpretation'] = this.enableInterpretation;
    data['register_option'] = this.registerOption;
    data['mail_notified'] = this.mailNotified;
    data['allowed_intervals'] = this.allowedIntervals;
    data['max_register'] = this.maxRegister;
    data['whiteboard_enabled'] = this.whiteboardEnabled;
    data['white_board_lock'] = this.whiteBoardLock;
    data['read_url'] = this.readUrl;
    data['write_url'] = this.writeUrl;
    data['webinar_host'] = this.webinarHost;
    data['host_left'] = this.hostLeft;
    data['restricted_mode'] = this.restrictedMode;
    data['doc_verify'] = this.docVerify;
    data['docverify_enabled'] = this.docverifyEnabled;
    data['document_guest_enabled'] = this.documentGuestEnabled;
    data['created_by'] = this.createdBy;
    return data;
  }
}

class Config {
  String? startWithVideoMuted;
  String? startWithAudioMuted;
  String? p2p;
  String? disableAP;
  String? disableAEC;
  String? disableNS;
  String? disableAGC;
  String? disableHPF;
  String? stereo;
  bool? brandLogo;
  bool? brandUrl;
  bool? brandColor;
  bool? brandInviteUrl;

  Config(
      {this.startWithVideoMuted,
        this.startWithAudioMuted,
        this.p2p,
        this.disableAP,
        this.disableAEC,
        this.disableNS,
        this.disableAGC,
        this.disableHPF,
        this.stereo,
        this.brandLogo,
        this.brandUrl,
        this.brandColor,
        this.brandInviteUrl});

  Config.fromJson(Map<String, dynamic> json) {
    startWithVideoMuted = json['startWithVideoMuted'];
    startWithAudioMuted = json['startWithAudioMuted'];
    p2p = json['p2p'];
    disableAP = json['disableAP'];
    disableAEC = json['disableAEC'];
    disableNS = json['disableNS'];
    disableAGC = json['disableAGC'];
    disableHPF = json['disableHPF'];
    stereo = json['stereo'];
    brandLogo = json['brand_logo'];
    brandUrl = json['brand_url'];
    brandColor = json['brand_color'];
    brandInviteUrl = json['brand_invite_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startWithVideoMuted'] = this.startWithVideoMuted;
    data['startWithAudioMuted'] = this.startWithAudioMuted;
    data['p2p'] = this.p2p;
    data['disableAP'] = this.disableAP;
    data['disableAEC'] = this.disableAEC;
    data['disableNS'] = this.disableNS;
    data['disableAGC'] = this.disableAGC;
    data['disableHPF'] = this.disableHPF;
    data['stereo'] = this.stereo;
    data['brand_logo'] = this.brandLogo;
    data['brand_url'] = this.brandUrl;
    data['brand_color'] = this.brandColor;
    data['brand_invite_url'] = this.brandInviteUrl;
    return data;
  }
}