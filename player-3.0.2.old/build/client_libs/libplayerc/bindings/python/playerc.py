# This file was created automatically by SWIG 1.3.29.
# Don't modify this file, modify the SWIG interface instead.
# This file is compatible with both classic and new-style classes.

import _playerc
import new
new_instancemethod = new.instancemethod
def _swig_setattr_nondynamic(self,class_type,name,value,static=1):
    if (name == "thisown"): return self.this.own(value)
    if (name == "this"):
        if type(value).__name__ == 'PySwigObject':
            self.__dict__[name] = value
            return
    method = class_type.__swig_setmethods__.get(name,None)
    if method: return method(self,value)
    if (not static) or hasattr(self,name):
        self.__dict__[name] = value
    else:
        raise AttributeError("You cannot add attributes to %s" % self)

def _swig_setattr(self,class_type,name,value):
    return _swig_setattr_nondynamic(self,class_type,name,value,0)

def _swig_getattr(self,class_type,name):
    if (name == "thisown"): return self.this.own()
    method = class_type.__swig_getmethods__.get(name,None)
    if method: return method(self)
    raise AttributeError,name

def _swig_repr(self):
    try: strthis = "proxy of " + self.this.__repr__()
    except: strthis = ""
    return "<%s.%s; %s >" % (self.__class__.__module__, self.__class__.__name__, strthis,)

import types
try:
    _object = types.ObjectType
    _newclass = 1
except AttributeError:
    class _object : pass
    _newclass = 0
del types


PLAYER_MAX_MESSAGE_SIZE = _playerc.PLAYER_MAX_MESSAGE_SIZE
PLAYER_MAX_DRIVER_STRING_LEN = _playerc.PLAYER_MAX_DRIVER_STRING_LEN
PLAYER_MAX_DEVICES = _playerc.PLAYER_MAX_DEVICES
PLAYER_MSGQUEUE_DEFAULT_MAXLEN = _playerc.PLAYER_MSGQUEUE_DEFAULT_MAXLEN
PLAYER_IDENT_STRING = _playerc.PLAYER_IDENT_STRING
PLAYER_IDENT_STRLEN = _playerc.PLAYER_IDENT_STRLEN
PLAYER_KEYLEN = _playerc.PLAYER_KEYLEN
PLAYER_MSGTYPE_DATA = _playerc.PLAYER_MSGTYPE_DATA
PLAYER_MSGTYPE_CMD = _playerc.PLAYER_MSGTYPE_CMD
PLAYER_MSGTYPE_REQ = _playerc.PLAYER_MSGTYPE_REQ
PLAYER_MSGTYPE_RESP_ACK = _playerc.PLAYER_MSGTYPE_RESP_ACK
PLAYER_MSGTYPE_SYNCH = _playerc.PLAYER_MSGTYPE_SYNCH
PLAYER_MSGTYPE_RESP_NACK = _playerc.PLAYER_MSGTYPE_RESP_NACK
class player_devaddr_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_devaddr_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_devaddr_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["host"] = _playerc.player_devaddr_t_host_set
    __swig_getmethods__["host"] = _playerc.player_devaddr_t_host_get
    if _newclass:host = property(_playerc.player_devaddr_t_host_get, _playerc.player_devaddr_t_host_set)
    __swig_setmethods__["robot"] = _playerc.player_devaddr_t_robot_set
    __swig_getmethods__["robot"] = _playerc.player_devaddr_t_robot_get
    if _newclass:robot = property(_playerc.player_devaddr_t_robot_get, _playerc.player_devaddr_t_robot_set)
    __swig_setmethods__["interf"] = _playerc.player_devaddr_t_interf_set
    __swig_getmethods__["interf"] = _playerc.player_devaddr_t_interf_get
    if _newclass:interf = property(_playerc.player_devaddr_t_interf_get, _playerc.player_devaddr_t_interf_set)
    __swig_setmethods__["index"] = _playerc.player_devaddr_t_index_set
    __swig_getmethods__["index"] = _playerc.player_devaddr_t_index_get
    if _newclass:index = property(_playerc.player_devaddr_t_index_get, _playerc.player_devaddr_t_index_set)
    def __init__(self, *args): 
        this = _playerc.new_player_devaddr_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_devaddr_t
    __del__ = lambda self : None;
player_devaddr_t_swigregister = _playerc.player_devaddr_t_swigregister
player_devaddr_t_swigregister(player_devaddr_t)

class player_msghdr_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_msghdr_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_msghdr_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["addr"] = _playerc.player_msghdr_t_addr_set
    __swig_getmethods__["addr"] = _playerc.player_msghdr_t_addr_get
    if _newclass:addr = property(_playerc.player_msghdr_t_addr_get, _playerc.player_msghdr_t_addr_set)
    __swig_setmethods__["type"] = _playerc.player_msghdr_t_type_set
    __swig_getmethods__["type"] = _playerc.player_msghdr_t_type_get
    if _newclass:type = property(_playerc.player_msghdr_t_type_get, _playerc.player_msghdr_t_type_set)
    __swig_setmethods__["subtype"] = _playerc.player_msghdr_t_subtype_set
    __swig_getmethods__["subtype"] = _playerc.player_msghdr_t_subtype_get
    if _newclass:subtype = property(_playerc.player_msghdr_t_subtype_get, _playerc.player_msghdr_t_subtype_set)
    __swig_setmethods__["timestamp"] = _playerc.player_msghdr_t_timestamp_set
    __swig_getmethods__["timestamp"] = _playerc.player_msghdr_t_timestamp_get
    if _newclass:timestamp = property(_playerc.player_msghdr_t_timestamp_get, _playerc.player_msghdr_t_timestamp_set)
    __swig_setmethods__["seq"] = _playerc.player_msghdr_t_seq_set
    __swig_getmethods__["seq"] = _playerc.player_msghdr_t_seq_get
    if _newclass:seq = property(_playerc.player_msghdr_t_seq_get, _playerc.player_msghdr_t_seq_set)
    __swig_setmethods__["size"] = _playerc.player_msghdr_t_size_set
    __swig_getmethods__["size"] = _playerc.player_msghdr_t_size_get
    if _newclass:size = property(_playerc.player_msghdr_t_size_get, _playerc.player_msghdr_t_size_set)
    def __init__(self, *args): 
        this = _playerc.new_player_msghdr_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_msghdr_t
    __del__ = lambda self : None;
player_msghdr_t_swigregister = _playerc.player_msghdr_t_swigregister
player_msghdr_t_swigregister(player_msghdr_t)

class player_point_2d_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_point_2d_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_point_2d_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["px"] = _playerc.player_point_2d_t_px_set
    __swig_getmethods__["px"] = _playerc.player_point_2d_t_px_get
    if _newclass:px = property(_playerc.player_point_2d_t_px_get, _playerc.player_point_2d_t_px_set)
    __swig_setmethods__["py"] = _playerc.player_point_2d_t_py_set
    __swig_getmethods__["py"] = _playerc.player_point_2d_t_py_get
    if _newclass:py = property(_playerc.player_point_2d_t_py_get, _playerc.player_point_2d_t_py_set)
    def __init__(self, *args): 
        this = _playerc.new_player_point_2d_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_point_2d_t
    __del__ = lambda self : None;
player_point_2d_t_swigregister = _playerc.player_point_2d_t_swigregister
player_point_2d_t_swigregister(player_point_2d_t)

class player_point_3d_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_point_3d_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_point_3d_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["px"] = _playerc.player_point_3d_t_px_set
    __swig_getmethods__["px"] = _playerc.player_point_3d_t_px_get
    if _newclass:px = property(_playerc.player_point_3d_t_px_get, _playerc.player_point_3d_t_px_set)
    __swig_setmethods__["py"] = _playerc.player_point_3d_t_py_set
    __swig_getmethods__["py"] = _playerc.player_point_3d_t_py_get
    if _newclass:py = property(_playerc.player_point_3d_t_py_get, _playerc.player_point_3d_t_py_set)
    __swig_setmethods__["pz"] = _playerc.player_point_3d_t_pz_set
    __swig_getmethods__["pz"] = _playerc.player_point_3d_t_pz_get
    if _newclass:pz = property(_playerc.player_point_3d_t_pz_get, _playerc.player_point_3d_t_pz_set)
    def __init__(self, *args): 
        this = _playerc.new_player_point_3d_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_point_3d_t
    __del__ = lambda self : None;
player_point_3d_t_swigregister = _playerc.player_point_3d_t_swigregister
player_point_3d_t_swigregister(player_point_3d_t)

class player_orientation_3d_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_orientation_3d_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_orientation_3d_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["proll"] = _playerc.player_orientation_3d_t_proll_set
    __swig_getmethods__["proll"] = _playerc.player_orientation_3d_t_proll_get
    if _newclass:proll = property(_playerc.player_orientation_3d_t_proll_get, _playerc.player_orientation_3d_t_proll_set)
    __swig_setmethods__["ppitch"] = _playerc.player_orientation_3d_t_ppitch_set
    __swig_getmethods__["ppitch"] = _playerc.player_orientation_3d_t_ppitch_get
    if _newclass:ppitch = property(_playerc.player_orientation_3d_t_ppitch_get, _playerc.player_orientation_3d_t_ppitch_set)
    __swig_setmethods__["pyaw"] = _playerc.player_orientation_3d_t_pyaw_set
    __swig_getmethods__["pyaw"] = _playerc.player_orientation_3d_t_pyaw_get
    if _newclass:pyaw = property(_playerc.player_orientation_3d_t_pyaw_get, _playerc.player_orientation_3d_t_pyaw_set)
    def __init__(self, *args): 
        this = _playerc.new_player_orientation_3d_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_orientation_3d_t
    __del__ = lambda self : None;
player_orientation_3d_t_swigregister = _playerc.player_orientation_3d_t_swigregister
player_orientation_3d_t_swigregister(player_orientation_3d_t)

class player_pose2d_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_pose2d_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_pose2d_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["px"] = _playerc.player_pose2d_t_px_set
    __swig_getmethods__["px"] = _playerc.player_pose2d_t_px_get
    if _newclass:px = property(_playerc.player_pose2d_t_px_get, _playerc.player_pose2d_t_px_set)
    __swig_setmethods__["py"] = _playerc.player_pose2d_t_py_set
    __swig_getmethods__["py"] = _playerc.player_pose2d_t_py_get
    if _newclass:py = property(_playerc.player_pose2d_t_py_get, _playerc.player_pose2d_t_py_set)
    __swig_setmethods__["pa"] = _playerc.player_pose2d_t_pa_set
    __swig_getmethods__["pa"] = _playerc.player_pose2d_t_pa_get
    if _newclass:pa = property(_playerc.player_pose2d_t_pa_get, _playerc.player_pose2d_t_pa_set)
    def __init__(self, *args): 
        this = _playerc.new_player_pose2d_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_pose2d_t
    __del__ = lambda self : None;
player_pose2d_t_swigregister = _playerc.player_pose2d_t_swigregister
player_pose2d_t_swigregister(player_pose2d_t)

class player_pose3d_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_pose3d_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_pose3d_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["px"] = _playerc.player_pose3d_t_px_set
    __swig_getmethods__["px"] = _playerc.player_pose3d_t_px_get
    if _newclass:px = property(_playerc.player_pose3d_t_px_get, _playerc.player_pose3d_t_px_set)
    __swig_setmethods__["py"] = _playerc.player_pose3d_t_py_set
    __swig_getmethods__["py"] = _playerc.player_pose3d_t_py_get
    if _newclass:py = property(_playerc.player_pose3d_t_py_get, _playerc.player_pose3d_t_py_set)
    __swig_setmethods__["pz"] = _playerc.player_pose3d_t_pz_set
    __swig_getmethods__["pz"] = _playerc.player_pose3d_t_pz_get
    if _newclass:pz = property(_playerc.player_pose3d_t_pz_get, _playerc.player_pose3d_t_pz_set)
    __swig_setmethods__["proll"] = _playerc.player_pose3d_t_proll_set
    __swig_getmethods__["proll"] = _playerc.player_pose3d_t_proll_get
    if _newclass:proll = property(_playerc.player_pose3d_t_proll_get, _playerc.player_pose3d_t_proll_set)
    __swig_setmethods__["ppitch"] = _playerc.player_pose3d_t_ppitch_set
    __swig_getmethods__["ppitch"] = _playerc.player_pose3d_t_ppitch_get
    if _newclass:ppitch = property(_playerc.player_pose3d_t_ppitch_get, _playerc.player_pose3d_t_ppitch_set)
    __swig_setmethods__["pyaw"] = _playerc.player_pose3d_t_pyaw_set
    __swig_getmethods__["pyaw"] = _playerc.player_pose3d_t_pyaw_get
    if _newclass:pyaw = property(_playerc.player_pose3d_t_pyaw_get, _playerc.player_pose3d_t_pyaw_set)
    def __init__(self, *args): 
        this = _playerc.new_player_pose3d_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_pose3d_t
    __del__ = lambda self : None;
player_pose3d_t_swigregister = _playerc.player_pose3d_t_swigregister
player_pose3d_t_swigregister(player_pose3d_t)

class player_bbox2d_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_bbox2d_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_bbox2d_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["sw"] = _playerc.player_bbox2d_t_sw_set
    __swig_getmethods__["sw"] = _playerc.player_bbox2d_t_sw_get
    if _newclass:sw = property(_playerc.player_bbox2d_t_sw_get, _playerc.player_bbox2d_t_sw_set)
    __swig_setmethods__["sl"] = _playerc.player_bbox2d_t_sl_set
    __swig_getmethods__["sl"] = _playerc.player_bbox2d_t_sl_get
    if _newclass:sl = property(_playerc.player_bbox2d_t_sl_get, _playerc.player_bbox2d_t_sl_set)
    def __init__(self, *args): 
        this = _playerc.new_player_bbox2d_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_bbox2d_t
    __del__ = lambda self : None;
player_bbox2d_t_swigregister = _playerc.player_bbox2d_t_swigregister
player_bbox2d_t_swigregister(player_bbox2d_t)

class player_bbox3d_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_bbox3d_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_bbox3d_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["sw"] = _playerc.player_bbox3d_t_sw_set
    __swig_getmethods__["sw"] = _playerc.player_bbox3d_t_sw_get
    if _newclass:sw = property(_playerc.player_bbox3d_t_sw_get, _playerc.player_bbox3d_t_sw_set)
    __swig_setmethods__["sl"] = _playerc.player_bbox3d_t_sl_set
    __swig_getmethods__["sl"] = _playerc.player_bbox3d_t_sl_get
    if _newclass:sl = property(_playerc.player_bbox3d_t_sl_get, _playerc.player_bbox3d_t_sl_set)
    __swig_setmethods__["sh"] = _playerc.player_bbox3d_t_sh_set
    __swig_getmethods__["sh"] = _playerc.player_bbox3d_t_sh_get
    if _newclass:sh = property(_playerc.player_bbox3d_t_sh_get, _playerc.player_bbox3d_t_sh_set)
    def __init__(self, *args): 
        this = _playerc.new_player_bbox3d_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_bbox3d_t
    __del__ = lambda self : None;
player_bbox3d_t_swigregister = _playerc.player_bbox3d_t_swigregister
player_bbox3d_t_swigregister(player_bbox3d_t)

class player_blackboard_entry_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_blackboard_entry_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_blackboard_entry_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["key_count"] = _playerc.player_blackboard_entry_t_key_count_set
    __swig_getmethods__["key_count"] = _playerc.player_blackboard_entry_t_key_count_get
    if _newclass:key_count = property(_playerc.player_blackboard_entry_t_key_count_get, _playerc.player_blackboard_entry_t_key_count_set)
    __swig_setmethods__["key"] = _playerc.player_blackboard_entry_t_key_set
    __swig_getmethods__["key"] = _playerc.player_blackboard_entry_t_key_get
    if _newclass:key = property(_playerc.player_blackboard_entry_t_key_get, _playerc.player_blackboard_entry_t_key_set)
    __swig_setmethods__["group_count"] = _playerc.player_blackboard_entry_t_group_count_set
    __swig_getmethods__["group_count"] = _playerc.player_blackboard_entry_t_group_count_get
    if _newclass:group_count = property(_playerc.player_blackboard_entry_t_group_count_get, _playerc.player_blackboard_entry_t_group_count_set)
    __swig_setmethods__["group"] = _playerc.player_blackboard_entry_t_group_set
    __swig_getmethods__["group"] = _playerc.player_blackboard_entry_t_group_get
    if _newclass:group = property(_playerc.player_blackboard_entry_t_group_get, _playerc.player_blackboard_entry_t_group_set)
    __swig_setmethods__["type"] = _playerc.player_blackboard_entry_t_type_set
    __swig_getmethods__["type"] = _playerc.player_blackboard_entry_t_type_get
    if _newclass:type = property(_playerc.player_blackboard_entry_t_type_get, _playerc.player_blackboard_entry_t_type_set)
    __swig_setmethods__["subtype"] = _playerc.player_blackboard_entry_t_subtype_set
    __swig_getmethods__["subtype"] = _playerc.player_blackboard_entry_t_subtype_get
    if _newclass:subtype = property(_playerc.player_blackboard_entry_t_subtype_get, _playerc.player_blackboard_entry_t_subtype_set)
    __swig_setmethods__["data_count"] = _playerc.player_blackboard_entry_t_data_count_set
    __swig_getmethods__["data_count"] = _playerc.player_blackboard_entry_t_data_count_get
    if _newclass:data_count = property(_playerc.player_blackboard_entry_t_data_count_get, _playerc.player_blackboard_entry_t_data_count_set)
    __swig_setmethods__["data"] = _playerc.player_blackboard_entry_t_data_set
    __swig_getmethods__["data"] = _playerc.player_blackboard_entry_t_data_get
    if _newclass:data = property(_playerc.player_blackboard_entry_t_data_get, _playerc.player_blackboard_entry_t_data_set)
    __swig_setmethods__["timestamp_sec"] = _playerc.player_blackboard_entry_t_timestamp_sec_set
    __swig_getmethods__["timestamp_sec"] = _playerc.player_blackboard_entry_t_timestamp_sec_get
    if _newclass:timestamp_sec = property(_playerc.player_blackboard_entry_t_timestamp_sec_get, _playerc.player_blackboard_entry_t_timestamp_sec_set)
    __swig_setmethods__["timestamp_usec"] = _playerc.player_blackboard_entry_t_timestamp_usec_set
    __swig_getmethods__["timestamp_usec"] = _playerc.player_blackboard_entry_t_timestamp_usec_get
    if _newclass:timestamp_usec = property(_playerc.player_blackboard_entry_t_timestamp_usec_get, _playerc.player_blackboard_entry_t_timestamp_usec_set)
    def __init__(self, *args): 
        this = _playerc.new_player_blackboard_entry_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_blackboard_entry_t
    __del__ = lambda self : None;
player_blackboard_entry_t_swigregister = _playerc.player_blackboard_entry_t_swigregister
player_blackboard_entry_t_swigregister(player_blackboard_entry_t)

class player_segment_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_segment_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_segment_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["x0"] = _playerc.player_segment_t_x0_set
    __swig_getmethods__["x0"] = _playerc.player_segment_t_x0_get
    if _newclass:x0 = property(_playerc.player_segment_t_x0_get, _playerc.player_segment_t_x0_set)
    __swig_setmethods__["y0"] = _playerc.player_segment_t_y0_set
    __swig_getmethods__["y0"] = _playerc.player_segment_t_y0_get
    if _newclass:y0 = property(_playerc.player_segment_t_y0_get, _playerc.player_segment_t_y0_set)
    __swig_setmethods__["x1"] = _playerc.player_segment_t_x1_set
    __swig_getmethods__["x1"] = _playerc.player_segment_t_x1_get
    if _newclass:x1 = property(_playerc.player_segment_t_x1_get, _playerc.player_segment_t_x1_set)
    __swig_setmethods__["y1"] = _playerc.player_segment_t_y1_set
    __swig_getmethods__["y1"] = _playerc.player_segment_t_y1_get
    if _newclass:y1 = property(_playerc.player_segment_t_y1_get, _playerc.player_segment_t_y1_set)
    def __init__(self, *args): 
        this = _playerc.new_player_segment_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_segment_t
    __del__ = lambda self : None;
player_segment_t_swigregister = _playerc.player_segment_t_swigregister
player_segment_t_swigregister(player_segment_t)

class player_extent2d_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_extent2d_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_extent2d_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["x0"] = _playerc.player_extent2d_t_x0_set
    __swig_getmethods__["x0"] = _playerc.player_extent2d_t_x0_get
    if _newclass:x0 = property(_playerc.player_extent2d_t_x0_get, _playerc.player_extent2d_t_x0_set)
    __swig_setmethods__["y0"] = _playerc.player_extent2d_t_y0_set
    __swig_getmethods__["y0"] = _playerc.player_extent2d_t_y0_get
    if _newclass:y0 = property(_playerc.player_extent2d_t_y0_get, _playerc.player_extent2d_t_y0_set)
    __swig_setmethods__["x1"] = _playerc.player_extent2d_t_x1_set
    __swig_getmethods__["x1"] = _playerc.player_extent2d_t_x1_get
    if _newclass:x1 = property(_playerc.player_extent2d_t_x1_get, _playerc.player_extent2d_t_x1_set)
    __swig_setmethods__["y1"] = _playerc.player_extent2d_t_y1_set
    __swig_getmethods__["y1"] = _playerc.player_extent2d_t_y1_get
    if _newclass:y1 = property(_playerc.player_extent2d_t_y1_get, _playerc.player_extent2d_t_y1_set)
    def __init__(self, *args): 
        this = _playerc.new_player_extent2d_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_extent2d_t
    __del__ = lambda self : None;
player_extent2d_t_swigregister = _playerc.player_extent2d_t_swigregister
player_extent2d_t_swigregister(player_extent2d_t)

class player_color_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_color_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_color_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["alpha"] = _playerc.player_color_t_alpha_set
    __swig_getmethods__["alpha"] = _playerc.player_color_t_alpha_get
    if _newclass:alpha = property(_playerc.player_color_t_alpha_get, _playerc.player_color_t_alpha_set)
    __swig_setmethods__["red"] = _playerc.player_color_t_red_set
    __swig_getmethods__["red"] = _playerc.player_color_t_red_get
    if _newclass:red = property(_playerc.player_color_t_red_get, _playerc.player_color_t_red_set)
    __swig_setmethods__["green"] = _playerc.player_color_t_green_set
    __swig_getmethods__["green"] = _playerc.player_color_t_green_get
    if _newclass:green = property(_playerc.player_color_t_green_get, _playerc.player_color_t_green_set)
    __swig_setmethods__["blue"] = _playerc.player_color_t_blue_set
    __swig_getmethods__["blue"] = _playerc.player_color_t_blue_get
    if _newclass:blue = property(_playerc.player_color_t_blue_get, _playerc.player_color_t_blue_set)
    def __init__(self, *args): 
        this = _playerc.new_player_color_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_color_t
    __del__ = lambda self : None;
player_color_t_swigregister = _playerc.player_color_t_swigregister
player_color_t_swigregister(player_color_t)

class player_bool_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_bool_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_bool_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_bool_t_state_set
    __swig_getmethods__["state"] = _playerc.player_bool_t_state_get
    if _newclass:state = property(_playerc.player_bool_t_state_get, _playerc.player_bool_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_bool_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_bool_t
    __del__ = lambda self : None;
player_bool_t_swigregister = _playerc.player_bool_t_swigregister
player_bool_t_swigregister(player_bool_t)

class player_uint32_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_uint32_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_uint32_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_uint32_t_value_set
    __swig_getmethods__["value"] = _playerc.player_uint32_t_value_get
    if _newclass:value = property(_playerc.player_uint32_t_value_get, _playerc.player_uint32_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_uint32_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_uint32_t
    __del__ = lambda self : None;
player_uint32_t_swigregister = _playerc.player_uint32_t_swigregister
player_uint32_t_swigregister(player_uint32_t)

PLAYER_CAPABILTIES_REQ = _playerc.PLAYER_CAPABILTIES_REQ
class player_capabilities_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_capabilities_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_capabilities_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["type"] = _playerc.player_capabilities_req_t_type_set
    __swig_getmethods__["type"] = _playerc.player_capabilities_req_t_type_get
    if _newclass:type = property(_playerc.player_capabilities_req_t_type_get, _playerc.player_capabilities_req_t_type_set)
    __swig_setmethods__["subtype"] = _playerc.player_capabilities_req_t_subtype_set
    __swig_getmethods__["subtype"] = _playerc.player_capabilities_req_t_subtype_get
    if _newclass:subtype = property(_playerc.player_capabilities_req_t_subtype_get, _playerc.player_capabilities_req_t_subtype_set)
    def __init__(self, *args): 
        this = _playerc.new_player_capabilities_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_capabilities_req_t
    __del__ = lambda self : None;
player_capabilities_req_t_swigregister = _playerc.player_capabilities_req_t_swigregister
player_capabilities_req_t_swigregister(player_capabilities_req_t)

PLAYER_GET_INTPROP_REQ = _playerc.PLAYER_GET_INTPROP_REQ
PLAYER_SET_INTPROP_REQ = _playerc.PLAYER_SET_INTPROP_REQ
PLAYER_GET_DBLPROP_REQ = _playerc.PLAYER_GET_DBLPROP_REQ
PLAYER_SET_DBLPROP_REQ = _playerc.PLAYER_SET_DBLPROP_REQ
PLAYER_GET_STRPROP_REQ = _playerc.PLAYER_GET_STRPROP_REQ
PLAYER_SET_STRPROP_REQ = _playerc.PLAYER_SET_STRPROP_REQ
PLAYER_GET_BOOLPROP_REQ = _playerc.PLAYER_GET_BOOLPROP_REQ
PLAYER_SET_BOOLPROP_REQ = _playerc.PLAYER_SET_BOOLPROP_REQ
class player_boolprop_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_boolprop_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_boolprop_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["key_count"] = _playerc.player_boolprop_req_t_key_count_set
    __swig_getmethods__["key_count"] = _playerc.player_boolprop_req_t_key_count_get
    if _newclass:key_count = property(_playerc.player_boolprop_req_t_key_count_get, _playerc.player_boolprop_req_t_key_count_set)
    __swig_setmethods__["key"] = _playerc.player_boolprop_req_t_key_set
    __swig_getmethods__["key"] = _playerc.player_boolprop_req_t_key_get
    if _newclass:key = property(_playerc.player_boolprop_req_t_key_get, _playerc.player_boolprop_req_t_key_set)
    __swig_setmethods__["value"] = _playerc.player_boolprop_req_t_value_set
    __swig_getmethods__["value"] = _playerc.player_boolprop_req_t_value_get
    if _newclass:value = property(_playerc.player_boolprop_req_t_value_get, _playerc.player_boolprop_req_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_boolprop_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_boolprop_req_t
    __del__ = lambda self : None;
player_boolprop_req_t_swigregister = _playerc.player_boolprop_req_t_swigregister
player_boolprop_req_t_swigregister(player_boolprop_req_t)

class player_intprop_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_intprop_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_intprop_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["key_count"] = _playerc.player_intprop_req_t_key_count_set
    __swig_getmethods__["key_count"] = _playerc.player_intprop_req_t_key_count_get
    if _newclass:key_count = property(_playerc.player_intprop_req_t_key_count_get, _playerc.player_intprop_req_t_key_count_set)
    __swig_setmethods__["key"] = _playerc.player_intprop_req_t_key_set
    __swig_getmethods__["key"] = _playerc.player_intprop_req_t_key_get
    if _newclass:key = property(_playerc.player_intprop_req_t_key_get, _playerc.player_intprop_req_t_key_set)
    __swig_setmethods__["value"] = _playerc.player_intprop_req_t_value_set
    __swig_getmethods__["value"] = _playerc.player_intprop_req_t_value_get
    if _newclass:value = property(_playerc.player_intprop_req_t_value_get, _playerc.player_intprop_req_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_intprop_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_intprop_req_t
    __del__ = lambda self : None;
player_intprop_req_t_swigregister = _playerc.player_intprop_req_t_swigregister
player_intprop_req_t_swigregister(player_intprop_req_t)

class player_dblprop_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_dblprop_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_dblprop_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["key_count"] = _playerc.player_dblprop_req_t_key_count_set
    __swig_getmethods__["key_count"] = _playerc.player_dblprop_req_t_key_count_get
    if _newclass:key_count = property(_playerc.player_dblprop_req_t_key_count_get, _playerc.player_dblprop_req_t_key_count_set)
    __swig_setmethods__["key"] = _playerc.player_dblprop_req_t_key_set
    __swig_getmethods__["key"] = _playerc.player_dblprop_req_t_key_get
    if _newclass:key = property(_playerc.player_dblprop_req_t_key_get, _playerc.player_dblprop_req_t_key_set)
    __swig_setmethods__["value"] = _playerc.player_dblprop_req_t_value_set
    __swig_getmethods__["value"] = _playerc.player_dblprop_req_t_value_get
    if _newclass:value = property(_playerc.player_dblprop_req_t_value_get, _playerc.player_dblprop_req_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_dblprop_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_dblprop_req_t
    __del__ = lambda self : None;
player_dblprop_req_t_swigregister = _playerc.player_dblprop_req_t_swigregister
player_dblprop_req_t_swigregister(player_dblprop_req_t)

class player_strprop_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_strprop_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_strprop_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["key_count"] = _playerc.player_strprop_req_t_key_count_set
    __swig_getmethods__["key_count"] = _playerc.player_strprop_req_t_key_count_get
    if _newclass:key_count = property(_playerc.player_strprop_req_t_key_count_get, _playerc.player_strprop_req_t_key_count_set)
    __swig_setmethods__["key"] = _playerc.player_strprop_req_t_key_set
    __swig_getmethods__["key"] = _playerc.player_strprop_req_t_key_get
    if _newclass:key = property(_playerc.player_strprop_req_t_key_get, _playerc.player_strprop_req_t_key_set)
    __swig_setmethods__["value_count"] = _playerc.player_strprop_req_t_value_count_set
    __swig_getmethods__["value_count"] = _playerc.player_strprop_req_t_value_count_get
    if _newclass:value_count = property(_playerc.player_strprop_req_t_value_count_get, _playerc.player_strprop_req_t_value_count_set)
    __swig_setmethods__["value"] = _playerc.player_strprop_req_t_value_set
    __swig_getmethods__["value"] = _playerc.player_strprop_req_t_value_get
    if _newclass:value = property(_playerc.player_strprop_req_t_value_get, _playerc.player_strprop_req_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_strprop_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_strprop_req_t
    __del__ = lambda self : None;
player_strprop_req_t_swigregister = _playerc.player_strprop_req_t_swigregister
player_strprop_req_t_swigregister(player_strprop_req_t)

PLAYER_PLAYER_CODE = _playerc.PLAYER_PLAYER_CODE
PLAYER_PLAYER_STRING = _playerc.PLAYER_PLAYER_STRING
PLAYER_PLAYER_REQ_DEVLIST = _playerc.PLAYER_PLAYER_REQ_DEVLIST
PLAYER_PLAYER_REQ_DRIVERINFO = _playerc.PLAYER_PLAYER_REQ_DRIVERINFO
PLAYER_PLAYER_REQ_DEV = _playerc.PLAYER_PLAYER_REQ_DEV
PLAYER_PLAYER_REQ_DATA = _playerc.PLAYER_PLAYER_REQ_DATA
PLAYER_PLAYER_REQ_DATAMODE = _playerc.PLAYER_PLAYER_REQ_DATAMODE
PLAYER_PLAYER_REQ_AUTH = _playerc.PLAYER_PLAYER_REQ_AUTH
PLAYER_PLAYER_REQ_NAMESERVICE = _playerc.PLAYER_PLAYER_REQ_NAMESERVICE
PLAYER_PLAYER_REQ_ADD_REPLACE_RULE = _playerc.PLAYER_PLAYER_REQ_ADD_REPLACE_RULE
PLAYER_PLAYER_SYNCH_OK = _playerc.PLAYER_PLAYER_SYNCH_OK
PLAYER_PLAYER_SYNCH_OVERFLOW = _playerc.PLAYER_PLAYER_SYNCH_OVERFLOW
PLAYER_OPEN_MODE = _playerc.PLAYER_OPEN_MODE
PLAYER_CLOSE_MODE = _playerc.PLAYER_CLOSE_MODE
PLAYER_ERROR_MODE = _playerc.PLAYER_ERROR_MODE
PLAYER_DATAMODE_PUSH = _playerc.PLAYER_DATAMODE_PUSH
PLAYER_DATAMODE_PULL = _playerc.PLAYER_DATAMODE_PULL
PLAYER_PLAYER_MSG_REPLACE_RULE_ACCEPT = _playerc.PLAYER_PLAYER_MSG_REPLACE_RULE_ACCEPT
PLAYER_PLAYER_MSG_REPLACE_RULE_REPLACE = _playerc.PLAYER_PLAYER_MSG_REPLACE_RULE_REPLACE
PLAYER_PLAYER_MSG_REPLACE_RULE_IGNORE = _playerc.PLAYER_PLAYER_MSG_REPLACE_RULE_IGNORE
class player_device_devlist_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_device_devlist_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_device_devlist_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["devices_count"] = _playerc.player_device_devlist_t_devices_count_set
    __swig_getmethods__["devices_count"] = _playerc.player_device_devlist_t_devices_count_get
    if _newclass:devices_count = property(_playerc.player_device_devlist_t_devices_count_get, _playerc.player_device_devlist_t_devices_count_set)
    __swig_setmethods__["devices"] = _playerc.player_device_devlist_t_devices_set
    __swig_getmethods__["devices"] = _playerc.player_device_devlist_t_devices_get
    if _newclass:devices = property(_playerc.player_device_devlist_t_devices_get, _playerc.player_device_devlist_t_devices_set)
    def __init__(self, *args): 
        this = _playerc.new_player_device_devlist_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_device_devlist_t
    __del__ = lambda self : None;
player_device_devlist_t_swigregister = _playerc.player_device_devlist_t_swigregister
player_device_devlist_t_swigregister(player_device_devlist_t)

class player_device_driverinfo_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_device_driverinfo_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_device_driverinfo_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["addr"] = _playerc.player_device_driverinfo_t_addr_set
    __swig_getmethods__["addr"] = _playerc.player_device_driverinfo_t_addr_get
    if _newclass:addr = property(_playerc.player_device_driverinfo_t_addr_get, _playerc.player_device_driverinfo_t_addr_set)
    __swig_setmethods__["driver_name_count"] = _playerc.player_device_driverinfo_t_driver_name_count_set
    __swig_getmethods__["driver_name_count"] = _playerc.player_device_driverinfo_t_driver_name_count_get
    if _newclass:driver_name_count = property(_playerc.player_device_driverinfo_t_driver_name_count_get, _playerc.player_device_driverinfo_t_driver_name_count_set)
    __swig_setmethods__["driver_name"] = _playerc.player_device_driverinfo_t_driver_name_set
    __swig_getmethods__["driver_name"] = _playerc.player_device_driverinfo_t_driver_name_get
    if _newclass:driver_name = property(_playerc.player_device_driverinfo_t_driver_name_get, _playerc.player_device_driverinfo_t_driver_name_set)
    def __init__(self, *args): 
        this = _playerc.new_player_device_driverinfo_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_device_driverinfo_t
    __del__ = lambda self : None;
player_device_driverinfo_t_swigregister = _playerc.player_device_driverinfo_t_swigregister
player_device_driverinfo_t_swigregister(player_device_driverinfo_t)

class player_device_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_device_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_device_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["addr"] = _playerc.player_device_req_t_addr_set
    __swig_getmethods__["addr"] = _playerc.player_device_req_t_addr_get
    if _newclass:addr = property(_playerc.player_device_req_t_addr_get, _playerc.player_device_req_t_addr_set)
    __swig_setmethods__["access"] = _playerc.player_device_req_t_access_set
    __swig_getmethods__["access"] = _playerc.player_device_req_t_access_get
    if _newclass:access = property(_playerc.player_device_req_t_access_get, _playerc.player_device_req_t_access_set)
    __swig_setmethods__["driver_name_count"] = _playerc.player_device_req_t_driver_name_count_set
    __swig_getmethods__["driver_name_count"] = _playerc.player_device_req_t_driver_name_count_get
    if _newclass:driver_name_count = property(_playerc.player_device_req_t_driver_name_count_get, _playerc.player_device_req_t_driver_name_count_set)
    __swig_setmethods__["driver_name"] = _playerc.player_device_req_t_driver_name_set
    __swig_getmethods__["driver_name"] = _playerc.player_device_req_t_driver_name_get
    if _newclass:driver_name = property(_playerc.player_device_req_t_driver_name_get, _playerc.player_device_req_t_driver_name_set)
    def __init__(self, *args): 
        this = _playerc.new_player_device_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_device_req_t
    __del__ = lambda self : None;
player_device_req_t_swigregister = _playerc.player_device_req_t_swigregister
player_device_req_t_swigregister(player_device_req_t)

class player_device_datamode_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_device_datamode_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_device_datamode_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["mode"] = _playerc.player_device_datamode_req_t_mode_set
    __swig_getmethods__["mode"] = _playerc.player_device_datamode_req_t_mode_get
    if _newclass:mode = property(_playerc.player_device_datamode_req_t_mode_get, _playerc.player_device_datamode_req_t_mode_set)
    def __init__(self, *args): 
        this = _playerc.new_player_device_datamode_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_device_datamode_req_t
    __del__ = lambda self : None;
player_device_datamode_req_t_swigregister = _playerc.player_device_datamode_req_t_swigregister
player_device_datamode_req_t_swigregister(player_device_datamode_req_t)

class player_device_auth_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_device_auth_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_device_auth_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["auth_key_count"] = _playerc.player_device_auth_req_t_auth_key_count_set
    __swig_getmethods__["auth_key_count"] = _playerc.player_device_auth_req_t_auth_key_count_get
    if _newclass:auth_key_count = property(_playerc.player_device_auth_req_t_auth_key_count_get, _playerc.player_device_auth_req_t_auth_key_count_set)
    __swig_setmethods__["auth_key"] = _playerc.player_device_auth_req_t_auth_key_set
    __swig_getmethods__["auth_key"] = _playerc.player_device_auth_req_t_auth_key_get
    if _newclass:auth_key = property(_playerc.player_device_auth_req_t_auth_key_get, _playerc.player_device_auth_req_t_auth_key_set)
    def __init__(self, *args): 
        this = _playerc.new_player_device_auth_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_device_auth_req_t
    __del__ = lambda self : None;
player_device_auth_req_t_swigregister = _playerc.player_device_auth_req_t_swigregister
player_device_auth_req_t_swigregister(player_device_auth_req_t)

class player_device_nameservice_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_device_nameservice_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_device_nameservice_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["name_count"] = _playerc.player_device_nameservice_req_t_name_count_set
    __swig_getmethods__["name_count"] = _playerc.player_device_nameservice_req_t_name_count_get
    if _newclass:name_count = property(_playerc.player_device_nameservice_req_t_name_count_get, _playerc.player_device_nameservice_req_t_name_count_set)
    __swig_setmethods__["name"] = _playerc.player_device_nameservice_req_t_name_set
    __swig_getmethods__["name"] = _playerc.player_device_nameservice_req_t_name_get
    if _newclass:name = property(_playerc.player_device_nameservice_req_t_name_get, _playerc.player_device_nameservice_req_t_name_set)
    __swig_setmethods__["port"] = _playerc.player_device_nameservice_req_t_port_set
    __swig_getmethods__["port"] = _playerc.player_device_nameservice_req_t_port_get
    if _newclass:port = property(_playerc.player_device_nameservice_req_t_port_get, _playerc.player_device_nameservice_req_t_port_set)
    def __init__(self, *args): 
        this = _playerc.new_player_device_nameservice_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_device_nameservice_req_t
    __del__ = lambda self : None;
player_device_nameservice_req_t_swigregister = _playerc.player_device_nameservice_req_t_swigregister
player_device_nameservice_req_t_swigregister(player_device_nameservice_req_t)

class player_add_replace_rule_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_add_replace_rule_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_add_replace_rule_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["interf"] = _playerc.player_add_replace_rule_req_t_interf_set
    __swig_getmethods__["interf"] = _playerc.player_add_replace_rule_req_t_interf_get
    if _newclass:interf = property(_playerc.player_add_replace_rule_req_t_interf_get, _playerc.player_add_replace_rule_req_t_interf_set)
    __swig_setmethods__["index"] = _playerc.player_add_replace_rule_req_t_index_set
    __swig_getmethods__["index"] = _playerc.player_add_replace_rule_req_t_index_get
    if _newclass:index = property(_playerc.player_add_replace_rule_req_t_index_get, _playerc.player_add_replace_rule_req_t_index_set)
    __swig_setmethods__["type"] = _playerc.player_add_replace_rule_req_t_type_set
    __swig_getmethods__["type"] = _playerc.player_add_replace_rule_req_t_type_get
    if _newclass:type = property(_playerc.player_add_replace_rule_req_t_type_get, _playerc.player_add_replace_rule_req_t_type_set)
    __swig_setmethods__["subtype"] = _playerc.player_add_replace_rule_req_t_subtype_set
    __swig_getmethods__["subtype"] = _playerc.player_add_replace_rule_req_t_subtype_get
    if _newclass:subtype = property(_playerc.player_add_replace_rule_req_t_subtype_get, _playerc.player_add_replace_rule_req_t_subtype_set)
    __swig_setmethods__["replace"] = _playerc.player_add_replace_rule_req_t_replace_set
    __swig_getmethods__["replace"] = _playerc.player_add_replace_rule_req_t_replace_get
    if _newclass:replace = property(_playerc.player_add_replace_rule_req_t_replace_get, _playerc.player_add_replace_rule_req_t_replace_set)
    def __init__(self, *args): 
        this = _playerc.new_player_add_replace_rule_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_add_replace_rule_req_t
    __del__ = lambda self : None;
player_add_replace_rule_req_t_swigregister = _playerc.player_add_replace_rule_req_t_swigregister
player_add_replace_rule_req_t_swigregister(player_add_replace_rule_req_t)

PLAYER_POWER_CODE = _playerc.PLAYER_POWER_CODE
PLAYER_POWER_STRING = _playerc.PLAYER_POWER_STRING
PLAYER_POWER_DATA_STATE = _playerc.PLAYER_POWER_DATA_STATE
PLAYER_POWER_REQ_SET_CHARGING_POLICY_REQ = _playerc.PLAYER_POWER_REQ_SET_CHARGING_POLICY_REQ
PLAYER_POWER_MASK_VOLTS = _playerc.PLAYER_POWER_MASK_VOLTS
PLAYER_POWER_MASK_WATTS = _playerc.PLAYER_POWER_MASK_WATTS
PLAYER_POWER_MASK_JOULES = _playerc.PLAYER_POWER_MASK_JOULES
PLAYER_POWER_MASK_PERCENT = _playerc.PLAYER_POWER_MASK_PERCENT
PLAYER_POWER_MASK_CHARGING = _playerc.PLAYER_POWER_MASK_CHARGING
class player_power_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_power_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_power_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["valid"] = _playerc.player_power_data_t_valid_set
    __swig_getmethods__["valid"] = _playerc.player_power_data_t_valid_get
    if _newclass:valid = property(_playerc.player_power_data_t_valid_get, _playerc.player_power_data_t_valid_set)
    __swig_setmethods__["volts"] = _playerc.player_power_data_t_volts_set
    __swig_getmethods__["volts"] = _playerc.player_power_data_t_volts_get
    if _newclass:volts = property(_playerc.player_power_data_t_volts_get, _playerc.player_power_data_t_volts_set)
    __swig_setmethods__["percent"] = _playerc.player_power_data_t_percent_set
    __swig_getmethods__["percent"] = _playerc.player_power_data_t_percent_get
    if _newclass:percent = property(_playerc.player_power_data_t_percent_get, _playerc.player_power_data_t_percent_set)
    __swig_setmethods__["joules"] = _playerc.player_power_data_t_joules_set
    __swig_getmethods__["joules"] = _playerc.player_power_data_t_joules_get
    if _newclass:joules = property(_playerc.player_power_data_t_joules_get, _playerc.player_power_data_t_joules_set)
    __swig_setmethods__["watts"] = _playerc.player_power_data_t_watts_set
    __swig_getmethods__["watts"] = _playerc.player_power_data_t_watts_get
    if _newclass:watts = property(_playerc.player_power_data_t_watts_get, _playerc.player_power_data_t_watts_set)
    __swig_setmethods__["charging"] = _playerc.player_power_data_t_charging_set
    __swig_getmethods__["charging"] = _playerc.player_power_data_t_charging_get
    if _newclass:charging = property(_playerc.player_power_data_t_charging_get, _playerc.player_power_data_t_charging_set)
    def __init__(self, *args): 
        this = _playerc.new_player_power_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_power_data_t
    __del__ = lambda self : None;
player_power_data_t_swigregister = _playerc.player_power_data_t_swigregister
player_power_data_t_swigregister(player_power_data_t)

class player_power_chargepolicy_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_power_chargepolicy_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_power_chargepolicy_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["enable_input"] = _playerc.player_power_chargepolicy_config_t_enable_input_set
    __swig_getmethods__["enable_input"] = _playerc.player_power_chargepolicy_config_t_enable_input_get
    if _newclass:enable_input = property(_playerc.player_power_chargepolicy_config_t_enable_input_get, _playerc.player_power_chargepolicy_config_t_enable_input_set)
    __swig_setmethods__["enable_output"] = _playerc.player_power_chargepolicy_config_t_enable_output_set
    __swig_getmethods__["enable_output"] = _playerc.player_power_chargepolicy_config_t_enable_output_get
    if _newclass:enable_output = property(_playerc.player_power_chargepolicy_config_t_enable_output_get, _playerc.player_power_chargepolicy_config_t_enable_output_set)
    def __init__(self, *args): 
        this = _playerc.new_player_power_chargepolicy_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_power_chargepolicy_config_t
    __del__ = lambda self : None;
player_power_chargepolicy_config_t_swigregister = _playerc.player_power_chargepolicy_config_t_swigregister
player_power_chargepolicy_config_t_swigregister(player_power_chargepolicy_config_t)

PLAYER_GRIPPER_CODE = _playerc.PLAYER_GRIPPER_CODE
PLAYER_GRIPPER_STRING = _playerc.PLAYER_GRIPPER_STRING
PLAYER_GRIPPER_DATA_STATE = _playerc.PLAYER_GRIPPER_DATA_STATE
PLAYER_GRIPPER_REQ_GET_GEOM = _playerc.PLAYER_GRIPPER_REQ_GET_GEOM
PLAYER_GRIPPER_CMD_OPEN = _playerc.PLAYER_GRIPPER_CMD_OPEN
PLAYER_GRIPPER_CMD_CLOSE = _playerc.PLAYER_GRIPPER_CMD_CLOSE
PLAYER_GRIPPER_CMD_STOP = _playerc.PLAYER_GRIPPER_CMD_STOP
PLAYER_GRIPPER_CMD_STORE = _playerc.PLAYER_GRIPPER_CMD_STORE
PLAYER_GRIPPER_CMD_RETRIEVE = _playerc.PLAYER_GRIPPER_CMD_RETRIEVE
PLAYER_GRIPPER_STATE_OPEN = _playerc.PLAYER_GRIPPER_STATE_OPEN
PLAYER_GRIPPER_STATE_CLOSED = _playerc.PLAYER_GRIPPER_STATE_CLOSED
PLAYER_GRIPPER_STATE_MOVING = _playerc.PLAYER_GRIPPER_STATE_MOVING
PLAYER_GRIPPER_STATE_ERROR = _playerc.PLAYER_GRIPPER_STATE_ERROR
class player_gripper_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_gripper_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_gripper_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_gripper_data_t_state_set
    __swig_getmethods__["state"] = _playerc.player_gripper_data_t_state_get
    if _newclass:state = property(_playerc.player_gripper_data_t_state_get, _playerc.player_gripper_data_t_state_set)
    __swig_setmethods__["beams"] = _playerc.player_gripper_data_t_beams_set
    __swig_getmethods__["beams"] = _playerc.player_gripper_data_t_beams_get
    if _newclass:beams = property(_playerc.player_gripper_data_t_beams_get, _playerc.player_gripper_data_t_beams_set)
    __swig_setmethods__["stored"] = _playerc.player_gripper_data_t_stored_set
    __swig_getmethods__["stored"] = _playerc.player_gripper_data_t_stored_get
    if _newclass:stored = property(_playerc.player_gripper_data_t_stored_get, _playerc.player_gripper_data_t_stored_set)
    def __init__(self, *args): 
        this = _playerc.new_player_gripper_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_gripper_data_t
    __del__ = lambda self : None;
player_gripper_data_t_swigregister = _playerc.player_gripper_data_t_swigregister
player_gripper_data_t_swigregister(player_gripper_data_t)

class player_gripper_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_gripper_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_gripper_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_gripper_geom_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_gripper_geom_t_pose_get
    if _newclass:pose = property(_playerc.player_gripper_geom_t_pose_get, _playerc.player_gripper_geom_t_pose_set)
    __swig_setmethods__["outer_size"] = _playerc.player_gripper_geom_t_outer_size_set
    __swig_getmethods__["outer_size"] = _playerc.player_gripper_geom_t_outer_size_get
    if _newclass:outer_size = property(_playerc.player_gripper_geom_t_outer_size_get, _playerc.player_gripper_geom_t_outer_size_set)
    __swig_setmethods__["inner_size"] = _playerc.player_gripper_geom_t_inner_size_set
    __swig_getmethods__["inner_size"] = _playerc.player_gripper_geom_t_inner_size_get
    if _newclass:inner_size = property(_playerc.player_gripper_geom_t_inner_size_get, _playerc.player_gripper_geom_t_inner_size_set)
    __swig_setmethods__["num_beams"] = _playerc.player_gripper_geom_t_num_beams_set
    __swig_getmethods__["num_beams"] = _playerc.player_gripper_geom_t_num_beams_get
    if _newclass:num_beams = property(_playerc.player_gripper_geom_t_num_beams_get, _playerc.player_gripper_geom_t_num_beams_set)
    __swig_setmethods__["capacity"] = _playerc.player_gripper_geom_t_capacity_set
    __swig_getmethods__["capacity"] = _playerc.player_gripper_geom_t_capacity_get
    if _newclass:capacity = property(_playerc.player_gripper_geom_t_capacity_get, _playerc.player_gripper_geom_t_capacity_set)
    def __init__(self, *args): 
        this = _playerc.new_player_gripper_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_gripper_geom_t
    __del__ = lambda self : None;
player_gripper_geom_t_swigregister = _playerc.player_gripper_geom_t_swigregister
player_gripper_geom_t_swigregister(player_gripper_geom_t)

PLAYER_POSITION2D_CODE = _playerc.PLAYER_POSITION2D_CODE
PLAYER_POSITION2D_STRING = _playerc.PLAYER_POSITION2D_STRING
PLAYER_POSITION2D_REQ_GET_GEOM = _playerc.PLAYER_POSITION2D_REQ_GET_GEOM
PLAYER_POSITION2D_REQ_MOTOR_POWER = _playerc.PLAYER_POSITION2D_REQ_MOTOR_POWER
PLAYER_POSITION2D_REQ_VELOCITY_MODE = _playerc.PLAYER_POSITION2D_REQ_VELOCITY_MODE
PLAYER_POSITION2D_REQ_POSITION_MODE = _playerc.PLAYER_POSITION2D_REQ_POSITION_MODE
PLAYER_POSITION2D_REQ_SET_ODOM = _playerc.PLAYER_POSITION2D_REQ_SET_ODOM
PLAYER_POSITION2D_REQ_RESET_ODOM = _playerc.PLAYER_POSITION2D_REQ_RESET_ODOM
PLAYER_POSITION2D_REQ_SPEED_PID = _playerc.PLAYER_POSITION2D_REQ_SPEED_PID
PLAYER_POSITION2D_REQ_POSITION_PID = _playerc.PLAYER_POSITION2D_REQ_POSITION_PID
PLAYER_POSITION2D_REQ_SPEED_PROF = _playerc.PLAYER_POSITION2D_REQ_SPEED_PROF
PLAYER_POSITION2D_DATA_STATE = _playerc.PLAYER_POSITION2D_DATA_STATE
PLAYER_POSITION2D_DATA_GEOM = _playerc.PLAYER_POSITION2D_DATA_GEOM
PLAYER_POSITION2D_CMD_VEL = _playerc.PLAYER_POSITION2D_CMD_VEL
PLAYER_POSITION2D_CMD_POS = _playerc.PLAYER_POSITION2D_CMD_POS
PLAYER_POSITION2D_CMD_CAR = _playerc.PLAYER_POSITION2D_CMD_CAR
PLAYER_POSITION2D_CMD_VEL_HEAD = _playerc.PLAYER_POSITION2D_CMD_VEL_HEAD
class player_position2d_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pos"] = _playerc.player_position2d_data_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_position2d_data_t_pos_get
    if _newclass:pos = property(_playerc.player_position2d_data_t_pos_get, _playerc.player_position2d_data_t_pos_set)
    __swig_setmethods__["vel"] = _playerc.player_position2d_data_t_vel_set
    __swig_getmethods__["vel"] = _playerc.player_position2d_data_t_vel_get
    if _newclass:vel = property(_playerc.player_position2d_data_t_vel_get, _playerc.player_position2d_data_t_vel_set)
    __swig_setmethods__["stall"] = _playerc.player_position2d_data_t_stall_set
    __swig_getmethods__["stall"] = _playerc.player_position2d_data_t_stall_get
    if _newclass:stall = property(_playerc.player_position2d_data_t_stall_get, _playerc.player_position2d_data_t_stall_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_data_t
    __del__ = lambda self : None;
player_position2d_data_t_swigregister = _playerc.player_position2d_data_t_swigregister
player_position2d_data_t_swigregister(player_position2d_data_t)

class player_position2d_cmd_vel_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_cmd_vel_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_cmd_vel_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["vel"] = _playerc.player_position2d_cmd_vel_t_vel_set
    __swig_getmethods__["vel"] = _playerc.player_position2d_cmd_vel_t_vel_get
    if _newclass:vel = property(_playerc.player_position2d_cmd_vel_t_vel_get, _playerc.player_position2d_cmd_vel_t_vel_set)
    __swig_setmethods__["state"] = _playerc.player_position2d_cmd_vel_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position2d_cmd_vel_t_state_get
    if _newclass:state = property(_playerc.player_position2d_cmd_vel_t_state_get, _playerc.player_position2d_cmd_vel_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_cmd_vel_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_cmd_vel_t
    __del__ = lambda self : None;
player_position2d_cmd_vel_t_swigregister = _playerc.player_position2d_cmd_vel_t_swigregister
player_position2d_cmd_vel_t_swigregister(player_position2d_cmd_vel_t)

class player_position2d_cmd_pos_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_cmd_pos_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_cmd_pos_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pos"] = _playerc.player_position2d_cmd_pos_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_position2d_cmd_pos_t_pos_get
    if _newclass:pos = property(_playerc.player_position2d_cmd_pos_t_pos_get, _playerc.player_position2d_cmd_pos_t_pos_set)
    __swig_setmethods__["vel"] = _playerc.player_position2d_cmd_pos_t_vel_set
    __swig_getmethods__["vel"] = _playerc.player_position2d_cmd_pos_t_vel_get
    if _newclass:vel = property(_playerc.player_position2d_cmd_pos_t_vel_get, _playerc.player_position2d_cmd_pos_t_vel_set)
    __swig_setmethods__["state"] = _playerc.player_position2d_cmd_pos_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position2d_cmd_pos_t_state_get
    if _newclass:state = property(_playerc.player_position2d_cmd_pos_t_state_get, _playerc.player_position2d_cmd_pos_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_cmd_pos_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_cmd_pos_t
    __del__ = lambda self : None;
player_position2d_cmd_pos_t_swigregister = _playerc.player_position2d_cmd_pos_t_swigregister
player_position2d_cmd_pos_t_swigregister(player_position2d_cmd_pos_t)

class player_position2d_cmd_car_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_cmd_car_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_cmd_car_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["velocity"] = _playerc.player_position2d_cmd_car_t_velocity_set
    __swig_getmethods__["velocity"] = _playerc.player_position2d_cmd_car_t_velocity_get
    if _newclass:velocity = property(_playerc.player_position2d_cmd_car_t_velocity_get, _playerc.player_position2d_cmd_car_t_velocity_set)
    __swig_setmethods__["angle"] = _playerc.player_position2d_cmd_car_t_angle_set
    __swig_getmethods__["angle"] = _playerc.player_position2d_cmd_car_t_angle_get
    if _newclass:angle = property(_playerc.player_position2d_cmd_car_t_angle_get, _playerc.player_position2d_cmd_car_t_angle_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_cmd_car_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_cmd_car_t
    __del__ = lambda self : None;
player_position2d_cmd_car_t_swigregister = _playerc.player_position2d_cmd_car_t_swigregister
player_position2d_cmd_car_t_swigregister(player_position2d_cmd_car_t)

class player_position2d_cmd_vel_head_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_cmd_vel_head_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_cmd_vel_head_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["velocity"] = _playerc.player_position2d_cmd_vel_head_t_velocity_set
    __swig_getmethods__["velocity"] = _playerc.player_position2d_cmd_vel_head_t_velocity_get
    if _newclass:velocity = property(_playerc.player_position2d_cmd_vel_head_t_velocity_get, _playerc.player_position2d_cmd_vel_head_t_velocity_set)
    __swig_setmethods__["angle"] = _playerc.player_position2d_cmd_vel_head_t_angle_set
    __swig_getmethods__["angle"] = _playerc.player_position2d_cmd_vel_head_t_angle_get
    if _newclass:angle = property(_playerc.player_position2d_cmd_vel_head_t_angle_get, _playerc.player_position2d_cmd_vel_head_t_angle_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_cmd_vel_head_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_cmd_vel_head_t
    __del__ = lambda self : None;
player_position2d_cmd_vel_head_t_swigregister = _playerc.player_position2d_cmd_vel_head_t_swigregister
player_position2d_cmd_vel_head_t_swigregister(player_position2d_cmd_vel_head_t)

class player_position2d_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_position2d_geom_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_position2d_geom_t_pose_get
    if _newclass:pose = property(_playerc.player_position2d_geom_t_pose_get, _playerc.player_position2d_geom_t_pose_set)
    __swig_setmethods__["size"] = _playerc.player_position2d_geom_t_size_set
    __swig_getmethods__["size"] = _playerc.player_position2d_geom_t_size_get
    if _newclass:size = property(_playerc.player_position2d_geom_t_size_get, _playerc.player_position2d_geom_t_size_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_geom_t
    __del__ = lambda self : None;
player_position2d_geom_t_swigregister = _playerc.player_position2d_geom_t_swigregister
player_position2d_geom_t_swigregister(player_position2d_geom_t)

class player_position2d_power_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_power_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_power_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_position2d_power_config_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position2d_power_config_t_state_get
    if _newclass:state = property(_playerc.player_position2d_power_config_t_state_get, _playerc.player_position2d_power_config_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_power_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_power_config_t
    __del__ = lambda self : None;
player_position2d_power_config_t_swigregister = _playerc.player_position2d_power_config_t_swigregister
player_position2d_power_config_t_swigregister(player_position2d_power_config_t)

class player_position2d_velocity_mode_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_velocity_mode_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_velocity_mode_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_position2d_velocity_mode_config_t_value_set
    __swig_getmethods__["value"] = _playerc.player_position2d_velocity_mode_config_t_value_get
    if _newclass:value = property(_playerc.player_position2d_velocity_mode_config_t_value_get, _playerc.player_position2d_velocity_mode_config_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_velocity_mode_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_velocity_mode_config_t
    __del__ = lambda self : None;
player_position2d_velocity_mode_config_t_swigregister = _playerc.player_position2d_velocity_mode_config_t_swigregister
player_position2d_velocity_mode_config_t_swigregister(player_position2d_velocity_mode_config_t)

class player_position2d_position_mode_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_position_mode_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_position_mode_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_position2d_position_mode_req_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position2d_position_mode_req_t_state_get
    if _newclass:state = property(_playerc.player_position2d_position_mode_req_t_state_get, _playerc.player_position2d_position_mode_req_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_position_mode_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_position_mode_req_t
    __del__ = lambda self : None;
player_position2d_position_mode_req_t_swigregister = _playerc.player_position2d_position_mode_req_t_swigregister
player_position2d_position_mode_req_t_swigregister(player_position2d_position_mode_req_t)

class player_position2d_set_odom_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_set_odom_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_set_odom_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_position2d_set_odom_req_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_position2d_set_odom_req_t_pose_get
    if _newclass:pose = property(_playerc.player_position2d_set_odom_req_t_pose_get, _playerc.player_position2d_set_odom_req_t_pose_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_set_odom_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_set_odom_req_t
    __del__ = lambda self : None;
player_position2d_set_odom_req_t_swigregister = _playerc.player_position2d_set_odom_req_t_swigregister
player_position2d_set_odom_req_t_swigregister(player_position2d_set_odom_req_t)

class player_position2d_speed_pid_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_speed_pid_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_speed_pid_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["kp"] = _playerc.player_position2d_speed_pid_req_t_kp_set
    __swig_getmethods__["kp"] = _playerc.player_position2d_speed_pid_req_t_kp_get
    if _newclass:kp = property(_playerc.player_position2d_speed_pid_req_t_kp_get, _playerc.player_position2d_speed_pid_req_t_kp_set)
    __swig_setmethods__["ki"] = _playerc.player_position2d_speed_pid_req_t_ki_set
    __swig_getmethods__["ki"] = _playerc.player_position2d_speed_pid_req_t_ki_get
    if _newclass:ki = property(_playerc.player_position2d_speed_pid_req_t_ki_get, _playerc.player_position2d_speed_pid_req_t_ki_set)
    __swig_setmethods__["kd"] = _playerc.player_position2d_speed_pid_req_t_kd_set
    __swig_getmethods__["kd"] = _playerc.player_position2d_speed_pid_req_t_kd_get
    if _newclass:kd = property(_playerc.player_position2d_speed_pid_req_t_kd_get, _playerc.player_position2d_speed_pid_req_t_kd_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_speed_pid_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_speed_pid_req_t
    __del__ = lambda self : None;
player_position2d_speed_pid_req_t_swigregister = _playerc.player_position2d_speed_pid_req_t_swigregister
player_position2d_speed_pid_req_t_swigregister(player_position2d_speed_pid_req_t)

class player_position2d_position_pid_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_position_pid_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_position_pid_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["kp"] = _playerc.player_position2d_position_pid_req_t_kp_set
    __swig_getmethods__["kp"] = _playerc.player_position2d_position_pid_req_t_kp_get
    if _newclass:kp = property(_playerc.player_position2d_position_pid_req_t_kp_get, _playerc.player_position2d_position_pid_req_t_kp_set)
    __swig_setmethods__["ki"] = _playerc.player_position2d_position_pid_req_t_ki_set
    __swig_getmethods__["ki"] = _playerc.player_position2d_position_pid_req_t_ki_get
    if _newclass:ki = property(_playerc.player_position2d_position_pid_req_t_ki_get, _playerc.player_position2d_position_pid_req_t_ki_set)
    __swig_setmethods__["kd"] = _playerc.player_position2d_position_pid_req_t_kd_set
    __swig_getmethods__["kd"] = _playerc.player_position2d_position_pid_req_t_kd_get
    if _newclass:kd = property(_playerc.player_position2d_position_pid_req_t_kd_get, _playerc.player_position2d_position_pid_req_t_kd_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_position_pid_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_position_pid_req_t
    __del__ = lambda self : None;
player_position2d_position_pid_req_t_swigregister = _playerc.player_position2d_position_pid_req_t_swigregister
player_position2d_position_pid_req_t_swigregister(player_position2d_position_pid_req_t)

class player_position2d_speed_prof_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position2d_speed_prof_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position2d_speed_prof_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["speed"] = _playerc.player_position2d_speed_prof_req_t_speed_set
    __swig_getmethods__["speed"] = _playerc.player_position2d_speed_prof_req_t_speed_get
    if _newclass:speed = property(_playerc.player_position2d_speed_prof_req_t_speed_get, _playerc.player_position2d_speed_prof_req_t_speed_set)
    __swig_setmethods__["acc"] = _playerc.player_position2d_speed_prof_req_t_acc_set
    __swig_getmethods__["acc"] = _playerc.player_position2d_speed_prof_req_t_acc_get
    if _newclass:acc = property(_playerc.player_position2d_speed_prof_req_t_acc_get, _playerc.player_position2d_speed_prof_req_t_acc_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position2d_speed_prof_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position2d_speed_prof_req_t
    __del__ = lambda self : None;
player_position2d_speed_prof_req_t_swigregister = _playerc.player_position2d_speed_prof_req_t_swigregister
player_position2d_speed_prof_req_t_swigregister(player_position2d_speed_prof_req_t)

PLAYER_SONAR_CODE = _playerc.PLAYER_SONAR_CODE
PLAYER_SONAR_STRING = _playerc.PLAYER_SONAR_STRING
PLAYER_SONAR_REQ_GET_GEOM = _playerc.PLAYER_SONAR_REQ_GET_GEOM
PLAYER_SONAR_REQ_POWER = _playerc.PLAYER_SONAR_REQ_POWER
PLAYER_SONAR_DATA_RANGES = _playerc.PLAYER_SONAR_DATA_RANGES
PLAYER_SONAR_DATA_GEOM = _playerc.PLAYER_SONAR_DATA_GEOM
class player_sonar_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_sonar_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_sonar_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["ranges_count"] = _playerc.player_sonar_data_t_ranges_count_set
    __swig_getmethods__["ranges_count"] = _playerc.player_sonar_data_t_ranges_count_get
    if _newclass:ranges_count = property(_playerc.player_sonar_data_t_ranges_count_get, _playerc.player_sonar_data_t_ranges_count_set)
    __swig_setmethods__["ranges"] = _playerc.player_sonar_data_t_ranges_set
    __swig_getmethods__["ranges"] = _playerc.player_sonar_data_t_ranges_get
    if _newclass:ranges = property(_playerc.player_sonar_data_t_ranges_get, _playerc.player_sonar_data_t_ranges_set)
    def __init__(self, *args): 
        this = _playerc.new_player_sonar_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_sonar_data_t
    __del__ = lambda self : None;
player_sonar_data_t_swigregister = _playerc.player_sonar_data_t_swigregister
player_sonar_data_t_swigregister(player_sonar_data_t)

class player_sonar_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_sonar_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_sonar_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["poses_count"] = _playerc.player_sonar_geom_t_poses_count_set
    __swig_getmethods__["poses_count"] = _playerc.player_sonar_geom_t_poses_count_get
    if _newclass:poses_count = property(_playerc.player_sonar_geom_t_poses_count_get, _playerc.player_sonar_geom_t_poses_count_set)
    __swig_setmethods__["poses"] = _playerc.player_sonar_geom_t_poses_set
    __swig_getmethods__["poses"] = _playerc.player_sonar_geom_t_poses_get
    if _newclass:poses = property(_playerc.player_sonar_geom_t_poses_get, _playerc.player_sonar_geom_t_poses_set)
    def __init__(self, *args): 
        this = _playerc.new_player_sonar_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_sonar_geom_t
    __del__ = lambda self : None;
player_sonar_geom_t_swigregister = _playerc.player_sonar_geom_t_swigregister
player_sonar_geom_t_swigregister(player_sonar_geom_t)

class player_sonar_power_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_sonar_power_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_sonar_power_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_sonar_power_config_t_state_set
    __swig_getmethods__["state"] = _playerc.player_sonar_power_config_t_state_get
    if _newclass:state = property(_playerc.player_sonar_power_config_t_state_get, _playerc.player_sonar_power_config_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_sonar_power_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_sonar_power_config_t
    __del__ = lambda self : None;
player_sonar_power_config_t_swigregister = _playerc.player_sonar_power_config_t_swigregister
player_sonar_power_config_t_swigregister(player_sonar_power_config_t)

PLAYER_LASER_CODE = _playerc.PLAYER_LASER_CODE
PLAYER_LASER_STRING = _playerc.PLAYER_LASER_STRING
PLAYER_LASER_DATA_SCAN = _playerc.PLAYER_LASER_DATA_SCAN
PLAYER_LASER_DATA_SCANPOSE = _playerc.PLAYER_LASER_DATA_SCANPOSE
PLAYER_LASER_DATA_SCANANGLE = _playerc.PLAYER_LASER_DATA_SCANANGLE
PLAYER_LASER_REQ_GET_GEOM = _playerc.PLAYER_LASER_REQ_GET_GEOM
PLAYER_LASER_REQ_SET_CONFIG = _playerc.PLAYER_LASER_REQ_SET_CONFIG
PLAYER_LASER_REQ_GET_CONFIG = _playerc.PLAYER_LASER_REQ_GET_CONFIG
PLAYER_LASER_REQ_POWER = _playerc.PLAYER_LASER_REQ_POWER
PLAYER_LASER_REQ_GET_ID = _playerc.PLAYER_LASER_REQ_GET_ID
PLAYER_LASER_REQ_SET_FILTER = _playerc.PLAYER_LASER_REQ_SET_FILTER
PLAYER_LASER_MAX_FILTER_PARAMS = _playerc.PLAYER_LASER_MAX_FILTER_PARAMS
PLAYER_LASER_FILTER_MEDIAN = _playerc.PLAYER_LASER_FILTER_MEDIAN
PLAYER_LASER_FILTER_EDGE = _playerc.PLAYER_LASER_FILTER_EDGE
PLAYER_LASER_FILTER_RANGE = _playerc.PLAYER_LASER_FILTER_RANGE
PLAYER_LASER_FILTER_MEAN = _playerc.PLAYER_LASER_FILTER_MEAN
class player_laser_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_laser_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_laser_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["min_angle"] = _playerc.player_laser_data_t_min_angle_set
    __swig_getmethods__["min_angle"] = _playerc.player_laser_data_t_min_angle_get
    if _newclass:min_angle = property(_playerc.player_laser_data_t_min_angle_get, _playerc.player_laser_data_t_min_angle_set)
    __swig_setmethods__["max_angle"] = _playerc.player_laser_data_t_max_angle_set
    __swig_getmethods__["max_angle"] = _playerc.player_laser_data_t_max_angle_get
    if _newclass:max_angle = property(_playerc.player_laser_data_t_max_angle_get, _playerc.player_laser_data_t_max_angle_set)
    __swig_setmethods__["resolution"] = _playerc.player_laser_data_t_resolution_set
    __swig_getmethods__["resolution"] = _playerc.player_laser_data_t_resolution_get
    if _newclass:resolution = property(_playerc.player_laser_data_t_resolution_get, _playerc.player_laser_data_t_resolution_set)
    __swig_setmethods__["max_range"] = _playerc.player_laser_data_t_max_range_set
    __swig_getmethods__["max_range"] = _playerc.player_laser_data_t_max_range_get
    if _newclass:max_range = property(_playerc.player_laser_data_t_max_range_get, _playerc.player_laser_data_t_max_range_set)
    __swig_setmethods__["ranges_count"] = _playerc.player_laser_data_t_ranges_count_set
    __swig_getmethods__["ranges_count"] = _playerc.player_laser_data_t_ranges_count_get
    if _newclass:ranges_count = property(_playerc.player_laser_data_t_ranges_count_get, _playerc.player_laser_data_t_ranges_count_set)
    __swig_setmethods__["ranges"] = _playerc.player_laser_data_t_ranges_set
    __swig_getmethods__["ranges"] = _playerc.player_laser_data_t_ranges_get
    if _newclass:ranges = property(_playerc.player_laser_data_t_ranges_get, _playerc.player_laser_data_t_ranges_set)
    __swig_setmethods__["intensity_count"] = _playerc.player_laser_data_t_intensity_count_set
    __swig_getmethods__["intensity_count"] = _playerc.player_laser_data_t_intensity_count_get
    if _newclass:intensity_count = property(_playerc.player_laser_data_t_intensity_count_get, _playerc.player_laser_data_t_intensity_count_set)
    __swig_setmethods__["intensity"] = _playerc.player_laser_data_t_intensity_set
    __swig_getmethods__["intensity"] = _playerc.player_laser_data_t_intensity_get
    if _newclass:intensity = property(_playerc.player_laser_data_t_intensity_get, _playerc.player_laser_data_t_intensity_set)
    __swig_setmethods__["id"] = _playerc.player_laser_data_t_id_set
    __swig_getmethods__["id"] = _playerc.player_laser_data_t_id_get
    if _newclass:id = property(_playerc.player_laser_data_t_id_get, _playerc.player_laser_data_t_id_set)
    def __init__(self, *args): 
        this = _playerc.new_player_laser_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_laser_data_t
    __del__ = lambda self : None;
player_laser_data_t_swigregister = _playerc.player_laser_data_t_swigregister
player_laser_data_t_swigregister(player_laser_data_t)

class player_laser_data_scanpose_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_laser_data_scanpose_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_laser_data_scanpose_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["scan"] = _playerc.player_laser_data_scanpose_t_scan_set
    __swig_getmethods__["scan"] = _playerc.player_laser_data_scanpose_t_scan_get
    if _newclass:scan = property(_playerc.player_laser_data_scanpose_t_scan_get, _playerc.player_laser_data_scanpose_t_scan_set)
    __swig_setmethods__["pose"] = _playerc.player_laser_data_scanpose_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_laser_data_scanpose_t_pose_get
    if _newclass:pose = property(_playerc.player_laser_data_scanpose_t_pose_get, _playerc.player_laser_data_scanpose_t_pose_set)
    def __init__(self, *args): 
        this = _playerc.new_player_laser_data_scanpose_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_laser_data_scanpose_t
    __del__ = lambda self : None;
player_laser_data_scanpose_t_swigregister = _playerc.player_laser_data_scanpose_t_swigregister
player_laser_data_scanpose_t_swigregister(player_laser_data_scanpose_t)

class player_laser_data_scanangle_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_laser_data_scanangle_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_laser_data_scanangle_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["max_range"] = _playerc.player_laser_data_scanangle_t_max_range_set
    __swig_getmethods__["max_range"] = _playerc.player_laser_data_scanangle_t_max_range_get
    if _newclass:max_range = property(_playerc.player_laser_data_scanangle_t_max_range_get, _playerc.player_laser_data_scanangle_t_max_range_set)
    __swig_setmethods__["ranges_count"] = _playerc.player_laser_data_scanangle_t_ranges_count_set
    __swig_getmethods__["ranges_count"] = _playerc.player_laser_data_scanangle_t_ranges_count_get
    if _newclass:ranges_count = property(_playerc.player_laser_data_scanangle_t_ranges_count_get, _playerc.player_laser_data_scanangle_t_ranges_count_set)
    __swig_setmethods__["ranges"] = _playerc.player_laser_data_scanangle_t_ranges_set
    __swig_getmethods__["ranges"] = _playerc.player_laser_data_scanangle_t_ranges_get
    if _newclass:ranges = property(_playerc.player_laser_data_scanangle_t_ranges_get, _playerc.player_laser_data_scanangle_t_ranges_set)
    __swig_setmethods__["angles_count"] = _playerc.player_laser_data_scanangle_t_angles_count_set
    __swig_getmethods__["angles_count"] = _playerc.player_laser_data_scanangle_t_angles_count_get
    if _newclass:angles_count = property(_playerc.player_laser_data_scanangle_t_angles_count_get, _playerc.player_laser_data_scanangle_t_angles_count_set)
    __swig_setmethods__["angles"] = _playerc.player_laser_data_scanangle_t_angles_set
    __swig_getmethods__["angles"] = _playerc.player_laser_data_scanangle_t_angles_get
    if _newclass:angles = property(_playerc.player_laser_data_scanangle_t_angles_get, _playerc.player_laser_data_scanangle_t_angles_set)
    __swig_setmethods__["intensity_count"] = _playerc.player_laser_data_scanangle_t_intensity_count_set
    __swig_getmethods__["intensity_count"] = _playerc.player_laser_data_scanangle_t_intensity_count_get
    if _newclass:intensity_count = property(_playerc.player_laser_data_scanangle_t_intensity_count_get, _playerc.player_laser_data_scanangle_t_intensity_count_set)
    __swig_setmethods__["intensity"] = _playerc.player_laser_data_scanangle_t_intensity_set
    __swig_getmethods__["intensity"] = _playerc.player_laser_data_scanangle_t_intensity_get
    if _newclass:intensity = property(_playerc.player_laser_data_scanangle_t_intensity_get, _playerc.player_laser_data_scanangle_t_intensity_set)
    __swig_setmethods__["id"] = _playerc.player_laser_data_scanangle_t_id_set
    __swig_getmethods__["id"] = _playerc.player_laser_data_scanangle_t_id_get
    if _newclass:id = property(_playerc.player_laser_data_scanangle_t_id_get, _playerc.player_laser_data_scanangle_t_id_set)
    def __init__(self, *args): 
        this = _playerc.new_player_laser_data_scanangle_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_laser_data_scanangle_t
    __del__ = lambda self : None;
player_laser_data_scanangle_t_swigregister = _playerc.player_laser_data_scanangle_t_swigregister
player_laser_data_scanangle_t_swigregister(player_laser_data_scanangle_t)

class player_laser_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_laser_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_laser_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_laser_geom_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_laser_geom_t_pose_get
    if _newclass:pose = property(_playerc.player_laser_geom_t_pose_get, _playerc.player_laser_geom_t_pose_set)
    __swig_setmethods__["size"] = _playerc.player_laser_geom_t_size_set
    __swig_getmethods__["size"] = _playerc.player_laser_geom_t_size_get
    if _newclass:size = property(_playerc.player_laser_geom_t_size_get, _playerc.player_laser_geom_t_size_set)
    def __init__(self, *args): 
        this = _playerc.new_player_laser_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_laser_geom_t
    __del__ = lambda self : None;
player_laser_geom_t_swigregister = _playerc.player_laser_geom_t_swigregister
player_laser_geom_t_swigregister(player_laser_geom_t)

class player_laser_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_laser_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_laser_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["min_angle"] = _playerc.player_laser_config_t_min_angle_set
    __swig_getmethods__["min_angle"] = _playerc.player_laser_config_t_min_angle_get
    if _newclass:min_angle = property(_playerc.player_laser_config_t_min_angle_get, _playerc.player_laser_config_t_min_angle_set)
    __swig_setmethods__["max_angle"] = _playerc.player_laser_config_t_max_angle_set
    __swig_getmethods__["max_angle"] = _playerc.player_laser_config_t_max_angle_get
    if _newclass:max_angle = property(_playerc.player_laser_config_t_max_angle_get, _playerc.player_laser_config_t_max_angle_set)
    __swig_setmethods__["resolution"] = _playerc.player_laser_config_t_resolution_set
    __swig_getmethods__["resolution"] = _playerc.player_laser_config_t_resolution_get
    if _newclass:resolution = property(_playerc.player_laser_config_t_resolution_get, _playerc.player_laser_config_t_resolution_set)
    __swig_setmethods__["max_range"] = _playerc.player_laser_config_t_max_range_set
    __swig_getmethods__["max_range"] = _playerc.player_laser_config_t_max_range_get
    if _newclass:max_range = property(_playerc.player_laser_config_t_max_range_get, _playerc.player_laser_config_t_max_range_set)
    __swig_setmethods__["range_res"] = _playerc.player_laser_config_t_range_res_set
    __swig_getmethods__["range_res"] = _playerc.player_laser_config_t_range_res_get
    if _newclass:range_res = property(_playerc.player_laser_config_t_range_res_get, _playerc.player_laser_config_t_range_res_set)
    __swig_setmethods__["intensity"] = _playerc.player_laser_config_t_intensity_set
    __swig_getmethods__["intensity"] = _playerc.player_laser_config_t_intensity_get
    if _newclass:intensity = property(_playerc.player_laser_config_t_intensity_get, _playerc.player_laser_config_t_intensity_set)
    __swig_setmethods__["scanning_frequency"] = _playerc.player_laser_config_t_scanning_frequency_set
    __swig_getmethods__["scanning_frequency"] = _playerc.player_laser_config_t_scanning_frequency_get
    if _newclass:scanning_frequency = property(_playerc.player_laser_config_t_scanning_frequency_get, _playerc.player_laser_config_t_scanning_frequency_set)
    def __init__(self, *args): 
        this = _playerc.new_player_laser_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_laser_config_t
    __del__ = lambda self : None;
player_laser_config_t_swigregister = _playerc.player_laser_config_t_swigregister
player_laser_config_t_swigregister(player_laser_config_t)

class player_laser_power_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_laser_power_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_laser_power_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_laser_power_config_t_state_set
    __swig_getmethods__["state"] = _playerc.player_laser_power_config_t_state_get
    if _newclass:state = property(_playerc.player_laser_power_config_t_state_get, _playerc.player_laser_power_config_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_laser_power_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_laser_power_config_t
    __del__ = lambda self : None;
player_laser_power_config_t_swigregister = _playerc.player_laser_power_config_t_swigregister
player_laser_power_config_t_swigregister(player_laser_power_config_t)

class player_laser_get_id_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_laser_get_id_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_laser_get_id_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["serial_number"] = _playerc.player_laser_get_id_config_t_serial_number_set
    __swig_getmethods__["serial_number"] = _playerc.player_laser_get_id_config_t_serial_number_get
    if _newclass:serial_number = property(_playerc.player_laser_get_id_config_t_serial_number_get, _playerc.player_laser_get_id_config_t_serial_number_set)
    def __init__(self, *args): 
        this = _playerc.new_player_laser_get_id_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_laser_get_id_config_t
    __del__ = lambda self : None;
player_laser_get_id_config_t_swigregister = _playerc.player_laser_get_id_config_t_swigregister
player_laser_get_id_config_t_swigregister(player_laser_get_id_config_t)

class player_laser_set_filter_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_laser_set_filter_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_laser_set_filter_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["filter_type"] = _playerc.player_laser_set_filter_config_t_filter_type_set
    __swig_getmethods__["filter_type"] = _playerc.player_laser_set_filter_config_t_filter_type_get
    if _newclass:filter_type = property(_playerc.player_laser_set_filter_config_t_filter_type_get, _playerc.player_laser_set_filter_config_t_filter_type_set)
    __swig_setmethods__["parameters_count"] = _playerc.player_laser_set_filter_config_t_parameters_count_set
    __swig_getmethods__["parameters_count"] = _playerc.player_laser_set_filter_config_t_parameters_count_get
    if _newclass:parameters_count = property(_playerc.player_laser_set_filter_config_t_parameters_count_get, _playerc.player_laser_set_filter_config_t_parameters_count_set)
    __swig_setmethods__["parameters"] = _playerc.player_laser_set_filter_config_t_parameters_set
    __swig_getmethods__["parameters"] = _playerc.player_laser_set_filter_config_t_parameters_get
    if _newclass:parameters = property(_playerc.player_laser_set_filter_config_t_parameters_get, _playerc.player_laser_set_filter_config_t_parameters_set)
    def __init__(self, *args): 
        this = _playerc.new_player_laser_set_filter_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_laser_set_filter_config_t
    __del__ = lambda self : None;
player_laser_set_filter_config_t_swigregister = _playerc.player_laser_set_filter_config_t_swigregister
player_laser_set_filter_config_t_swigregister(player_laser_set_filter_config_t)

PLAYER_BLOBFINDER_CODE = _playerc.PLAYER_BLOBFINDER_CODE
PLAYER_BLOBFINDER_STRING = _playerc.PLAYER_BLOBFINDER_STRING
PLAYER_BLOBFINDER_DATA_BLOBS = _playerc.PLAYER_BLOBFINDER_DATA_BLOBS
PLAYER_BLOBFINDER_REQ_SET_COLOR = _playerc.PLAYER_BLOBFINDER_REQ_SET_COLOR
PLAYER_BLOBFINDER_REQ_SET_IMAGER_PARAMS = _playerc.PLAYER_BLOBFINDER_REQ_SET_IMAGER_PARAMS
PLAYER_BLOBFINDER_REQ_GET_COLOR = _playerc.PLAYER_BLOBFINDER_REQ_GET_COLOR
class player_blobfinder_blob_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_blobfinder_blob_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_blobfinder_blob_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["id"] = _playerc.player_blobfinder_blob_t_id_set
    __swig_getmethods__["id"] = _playerc.player_blobfinder_blob_t_id_get
    if _newclass:id = property(_playerc.player_blobfinder_blob_t_id_get, _playerc.player_blobfinder_blob_t_id_set)
    __swig_setmethods__["color"] = _playerc.player_blobfinder_blob_t_color_set
    __swig_getmethods__["color"] = _playerc.player_blobfinder_blob_t_color_get
    if _newclass:color = property(_playerc.player_blobfinder_blob_t_color_get, _playerc.player_blobfinder_blob_t_color_set)
    __swig_setmethods__["area"] = _playerc.player_blobfinder_blob_t_area_set
    __swig_getmethods__["area"] = _playerc.player_blobfinder_blob_t_area_get
    if _newclass:area = property(_playerc.player_blobfinder_blob_t_area_get, _playerc.player_blobfinder_blob_t_area_set)
    __swig_setmethods__["x"] = _playerc.player_blobfinder_blob_t_x_set
    __swig_getmethods__["x"] = _playerc.player_blobfinder_blob_t_x_get
    if _newclass:x = property(_playerc.player_blobfinder_blob_t_x_get, _playerc.player_blobfinder_blob_t_x_set)
    __swig_setmethods__["y"] = _playerc.player_blobfinder_blob_t_y_set
    __swig_getmethods__["y"] = _playerc.player_blobfinder_blob_t_y_get
    if _newclass:y = property(_playerc.player_blobfinder_blob_t_y_get, _playerc.player_blobfinder_blob_t_y_set)
    __swig_setmethods__["left"] = _playerc.player_blobfinder_blob_t_left_set
    __swig_getmethods__["left"] = _playerc.player_blobfinder_blob_t_left_get
    if _newclass:left = property(_playerc.player_blobfinder_blob_t_left_get, _playerc.player_blobfinder_blob_t_left_set)
    __swig_setmethods__["right"] = _playerc.player_blobfinder_blob_t_right_set
    __swig_getmethods__["right"] = _playerc.player_blobfinder_blob_t_right_get
    if _newclass:right = property(_playerc.player_blobfinder_blob_t_right_get, _playerc.player_blobfinder_blob_t_right_set)
    __swig_setmethods__["top"] = _playerc.player_blobfinder_blob_t_top_set
    __swig_getmethods__["top"] = _playerc.player_blobfinder_blob_t_top_get
    if _newclass:top = property(_playerc.player_blobfinder_blob_t_top_get, _playerc.player_blobfinder_blob_t_top_set)
    __swig_setmethods__["bottom"] = _playerc.player_blobfinder_blob_t_bottom_set
    __swig_getmethods__["bottom"] = _playerc.player_blobfinder_blob_t_bottom_get
    if _newclass:bottom = property(_playerc.player_blobfinder_blob_t_bottom_get, _playerc.player_blobfinder_blob_t_bottom_set)
    __swig_setmethods__["range"] = _playerc.player_blobfinder_blob_t_range_set
    __swig_getmethods__["range"] = _playerc.player_blobfinder_blob_t_range_get
    if _newclass:range = property(_playerc.player_blobfinder_blob_t_range_get, _playerc.player_blobfinder_blob_t_range_set)
    def __init__(self, *args): 
        this = _playerc.new_player_blobfinder_blob_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_blobfinder_blob_t
    __del__ = lambda self : None;
player_blobfinder_blob_t_swigregister = _playerc.player_blobfinder_blob_t_swigregister
player_blobfinder_blob_t_swigregister(player_blobfinder_blob_t)

class player_blobfinder_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_blobfinder_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_blobfinder_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["width"] = _playerc.player_blobfinder_data_t_width_set
    __swig_getmethods__["width"] = _playerc.player_blobfinder_data_t_width_get
    if _newclass:width = property(_playerc.player_blobfinder_data_t_width_get, _playerc.player_blobfinder_data_t_width_set)
    __swig_setmethods__["height"] = _playerc.player_blobfinder_data_t_height_set
    __swig_getmethods__["height"] = _playerc.player_blobfinder_data_t_height_get
    if _newclass:height = property(_playerc.player_blobfinder_data_t_height_get, _playerc.player_blobfinder_data_t_height_set)
    __swig_setmethods__["blobs_count"] = _playerc.player_blobfinder_data_t_blobs_count_set
    __swig_getmethods__["blobs_count"] = _playerc.player_blobfinder_data_t_blobs_count_get
    if _newclass:blobs_count = property(_playerc.player_blobfinder_data_t_blobs_count_get, _playerc.player_blobfinder_data_t_blobs_count_set)
    __swig_setmethods__["blobs"] = _playerc.player_blobfinder_data_t_blobs_set
    __swig_getmethods__["blobs"] = _playerc.player_blobfinder_data_t_blobs_get
    if _newclass:blobs = property(_playerc.player_blobfinder_data_t_blobs_get, _playerc.player_blobfinder_data_t_blobs_set)
    def __init__(self, *args): 
        this = _playerc.new_player_blobfinder_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_blobfinder_data_t
    __del__ = lambda self : None;
player_blobfinder_data_t_swigregister = _playerc.player_blobfinder_data_t_swigregister
player_blobfinder_data_t_swigregister(player_blobfinder_data_t)

class player_blobfinder_color_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_blobfinder_color_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_blobfinder_color_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["channel"] = _playerc.player_blobfinder_color_config_t_channel_set
    __swig_getmethods__["channel"] = _playerc.player_blobfinder_color_config_t_channel_get
    if _newclass:channel = property(_playerc.player_blobfinder_color_config_t_channel_get, _playerc.player_blobfinder_color_config_t_channel_set)
    __swig_setmethods__["rmin"] = _playerc.player_blobfinder_color_config_t_rmin_set
    __swig_getmethods__["rmin"] = _playerc.player_blobfinder_color_config_t_rmin_get
    if _newclass:rmin = property(_playerc.player_blobfinder_color_config_t_rmin_get, _playerc.player_blobfinder_color_config_t_rmin_set)
    __swig_setmethods__["rmax"] = _playerc.player_blobfinder_color_config_t_rmax_set
    __swig_getmethods__["rmax"] = _playerc.player_blobfinder_color_config_t_rmax_get
    if _newclass:rmax = property(_playerc.player_blobfinder_color_config_t_rmax_get, _playerc.player_blobfinder_color_config_t_rmax_set)
    __swig_setmethods__["gmin"] = _playerc.player_blobfinder_color_config_t_gmin_set
    __swig_getmethods__["gmin"] = _playerc.player_blobfinder_color_config_t_gmin_get
    if _newclass:gmin = property(_playerc.player_blobfinder_color_config_t_gmin_get, _playerc.player_blobfinder_color_config_t_gmin_set)
    __swig_setmethods__["gmax"] = _playerc.player_blobfinder_color_config_t_gmax_set
    __swig_getmethods__["gmax"] = _playerc.player_blobfinder_color_config_t_gmax_get
    if _newclass:gmax = property(_playerc.player_blobfinder_color_config_t_gmax_get, _playerc.player_blobfinder_color_config_t_gmax_set)
    __swig_setmethods__["bmin"] = _playerc.player_blobfinder_color_config_t_bmin_set
    __swig_getmethods__["bmin"] = _playerc.player_blobfinder_color_config_t_bmin_get
    if _newclass:bmin = property(_playerc.player_blobfinder_color_config_t_bmin_get, _playerc.player_blobfinder_color_config_t_bmin_set)
    __swig_setmethods__["bmax"] = _playerc.player_blobfinder_color_config_t_bmax_set
    __swig_getmethods__["bmax"] = _playerc.player_blobfinder_color_config_t_bmax_get
    if _newclass:bmax = property(_playerc.player_blobfinder_color_config_t_bmax_get, _playerc.player_blobfinder_color_config_t_bmax_set)
    def __init__(self, *args): 
        this = _playerc.new_player_blobfinder_color_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_blobfinder_color_config_t
    __del__ = lambda self : None;
player_blobfinder_color_config_t_swigregister = _playerc.player_blobfinder_color_config_t_swigregister
player_blobfinder_color_config_t_swigregister(player_blobfinder_color_config_t)

class player_blobfinder_imager_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_blobfinder_imager_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_blobfinder_imager_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["brightness"] = _playerc.player_blobfinder_imager_config_t_brightness_set
    __swig_getmethods__["brightness"] = _playerc.player_blobfinder_imager_config_t_brightness_get
    if _newclass:brightness = property(_playerc.player_blobfinder_imager_config_t_brightness_get, _playerc.player_blobfinder_imager_config_t_brightness_set)
    __swig_setmethods__["contrast"] = _playerc.player_blobfinder_imager_config_t_contrast_set
    __swig_getmethods__["contrast"] = _playerc.player_blobfinder_imager_config_t_contrast_get
    if _newclass:contrast = property(_playerc.player_blobfinder_imager_config_t_contrast_get, _playerc.player_blobfinder_imager_config_t_contrast_set)
    __swig_setmethods__["colormode"] = _playerc.player_blobfinder_imager_config_t_colormode_set
    __swig_getmethods__["colormode"] = _playerc.player_blobfinder_imager_config_t_colormode_get
    if _newclass:colormode = property(_playerc.player_blobfinder_imager_config_t_colormode_get, _playerc.player_blobfinder_imager_config_t_colormode_set)
    __swig_setmethods__["autogain"] = _playerc.player_blobfinder_imager_config_t_autogain_set
    __swig_getmethods__["autogain"] = _playerc.player_blobfinder_imager_config_t_autogain_get
    if _newclass:autogain = property(_playerc.player_blobfinder_imager_config_t_autogain_get, _playerc.player_blobfinder_imager_config_t_autogain_set)
    def __init__(self, *args): 
        this = _playerc.new_player_blobfinder_imager_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_blobfinder_imager_config_t
    __del__ = lambda self : None;
player_blobfinder_imager_config_t_swigregister = _playerc.player_blobfinder_imager_config_t_swigregister
player_blobfinder_imager_config_t_swigregister(player_blobfinder_imager_config_t)

PLAYER_PTZ_CODE = _playerc.PLAYER_PTZ_CODE
PLAYER_PTZ_STRING = _playerc.PLAYER_PTZ_STRING
PLAYER_PTZ_REQ_GENERIC = _playerc.PLAYER_PTZ_REQ_GENERIC
PLAYER_PTZ_REQ_CONTROL_MODE = _playerc.PLAYER_PTZ_REQ_CONTROL_MODE
PLAYER_PTZ_REQ_GEOM = _playerc.PLAYER_PTZ_REQ_GEOM
PLAYER_PTZ_REQ_STATUS = _playerc.PLAYER_PTZ_REQ_STATUS
PLAYER_PTZ_DATA_STATE = _playerc.PLAYER_PTZ_DATA_STATE
PLAYER_PTZ_DATA_GEOM = _playerc.PLAYER_PTZ_DATA_GEOM
PLAYER_PTZ_CMD_STATE = _playerc.PLAYER_PTZ_CMD_STATE
PLAYER_PTZ_VELOCITY_CONTROL = _playerc.PLAYER_PTZ_VELOCITY_CONTROL
PLAYER_PTZ_POSITION_CONTROL = _playerc.PLAYER_PTZ_POSITION_CONTROL
class player_ptz_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ptz_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ptz_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pan"] = _playerc.player_ptz_data_t_pan_set
    __swig_getmethods__["pan"] = _playerc.player_ptz_data_t_pan_get
    if _newclass:pan = property(_playerc.player_ptz_data_t_pan_get, _playerc.player_ptz_data_t_pan_set)
    __swig_setmethods__["tilt"] = _playerc.player_ptz_data_t_tilt_set
    __swig_getmethods__["tilt"] = _playerc.player_ptz_data_t_tilt_get
    if _newclass:tilt = property(_playerc.player_ptz_data_t_tilt_get, _playerc.player_ptz_data_t_tilt_set)
    __swig_setmethods__["zoom"] = _playerc.player_ptz_data_t_zoom_set
    __swig_getmethods__["zoom"] = _playerc.player_ptz_data_t_zoom_get
    if _newclass:zoom = property(_playerc.player_ptz_data_t_zoom_get, _playerc.player_ptz_data_t_zoom_set)
    __swig_setmethods__["panspeed"] = _playerc.player_ptz_data_t_panspeed_set
    __swig_getmethods__["panspeed"] = _playerc.player_ptz_data_t_panspeed_get
    if _newclass:panspeed = property(_playerc.player_ptz_data_t_panspeed_get, _playerc.player_ptz_data_t_panspeed_set)
    __swig_setmethods__["tiltspeed"] = _playerc.player_ptz_data_t_tiltspeed_set
    __swig_getmethods__["tiltspeed"] = _playerc.player_ptz_data_t_tiltspeed_get
    if _newclass:tiltspeed = property(_playerc.player_ptz_data_t_tiltspeed_get, _playerc.player_ptz_data_t_tiltspeed_set)
    __swig_setmethods__["status"] = _playerc.player_ptz_data_t_status_set
    __swig_getmethods__["status"] = _playerc.player_ptz_data_t_status_get
    if _newclass:status = property(_playerc.player_ptz_data_t_status_get, _playerc.player_ptz_data_t_status_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ptz_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ptz_data_t
    __del__ = lambda self : None;
player_ptz_data_t_swigregister = _playerc.player_ptz_data_t_swigregister
player_ptz_data_t_swigregister(player_ptz_data_t)

class player_ptz_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ptz_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ptz_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pan"] = _playerc.player_ptz_cmd_t_pan_set
    __swig_getmethods__["pan"] = _playerc.player_ptz_cmd_t_pan_get
    if _newclass:pan = property(_playerc.player_ptz_cmd_t_pan_get, _playerc.player_ptz_cmd_t_pan_set)
    __swig_setmethods__["tilt"] = _playerc.player_ptz_cmd_t_tilt_set
    __swig_getmethods__["tilt"] = _playerc.player_ptz_cmd_t_tilt_get
    if _newclass:tilt = property(_playerc.player_ptz_cmd_t_tilt_get, _playerc.player_ptz_cmd_t_tilt_set)
    __swig_setmethods__["zoom"] = _playerc.player_ptz_cmd_t_zoom_set
    __swig_getmethods__["zoom"] = _playerc.player_ptz_cmd_t_zoom_get
    if _newclass:zoom = property(_playerc.player_ptz_cmd_t_zoom_get, _playerc.player_ptz_cmd_t_zoom_set)
    __swig_setmethods__["panspeed"] = _playerc.player_ptz_cmd_t_panspeed_set
    __swig_getmethods__["panspeed"] = _playerc.player_ptz_cmd_t_panspeed_get
    if _newclass:panspeed = property(_playerc.player_ptz_cmd_t_panspeed_get, _playerc.player_ptz_cmd_t_panspeed_set)
    __swig_setmethods__["tiltspeed"] = _playerc.player_ptz_cmd_t_tiltspeed_set
    __swig_getmethods__["tiltspeed"] = _playerc.player_ptz_cmd_t_tiltspeed_get
    if _newclass:tiltspeed = property(_playerc.player_ptz_cmd_t_tiltspeed_get, _playerc.player_ptz_cmd_t_tiltspeed_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ptz_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ptz_cmd_t
    __del__ = lambda self : None;
player_ptz_cmd_t_swigregister = _playerc.player_ptz_cmd_t_swigregister
player_ptz_cmd_t_swigregister(player_ptz_cmd_t)

class player_ptz_req_status_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ptz_req_status_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ptz_req_status_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["status"] = _playerc.player_ptz_req_status_t_status_set
    __swig_getmethods__["status"] = _playerc.player_ptz_req_status_t_status_get
    if _newclass:status = property(_playerc.player_ptz_req_status_t_status_get, _playerc.player_ptz_req_status_t_status_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ptz_req_status_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ptz_req_status_t
    __del__ = lambda self : None;
player_ptz_req_status_t_swigregister = _playerc.player_ptz_req_status_t_swigregister
player_ptz_req_status_t_swigregister(player_ptz_req_status_t)

class player_ptz_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ptz_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ptz_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pos"] = _playerc.player_ptz_geom_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_ptz_geom_t_pos_get
    if _newclass:pos = property(_playerc.player_ptz_geom_t_pos_get, _playerc.player_ptz_geom_t_pos_set)
    __swig_setmethods__["size"] = _playerc.player_ptz_geom_t_size_set
    __swig_getmethods__["size"] = _playerc.player_ptz_geom_t_size_get
    if _newclass:size = property(_playerc.player_ptz_geom_t_size_get, _playerc.player_ptz_geom_t_size_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ptz_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ptz_geom_t
    __del__ = lambda self : None;
player_ptz_geom_t_swigregister = _playerc.player_ptz_geom_t_swigregister
player_ptz_geom_t_swigregister(player_ptz_geom_t)

class player_ptz_req_generic_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ptz_req_generic_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ptz_req_generic_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["config_count"] = _playerc.player_ptz_req_generic_t_config_count_set
    __swig_getmethods__["config_count"] = _playerc.player_ptz_req_generic_t_config_count_get
    if _newclass:config_count = property(_playerc.player_ptz_req_generic_t_config_count_get, _playerc.player_ptz_req_generic_t_config_count_set)
    __swig_setmethods__["config"] = _playerc.player_ptz_req_generic_t_config_set
    __swig_getmethods__["config"] = _playerc.player_ptz_req_generic_t_config_get
    if _newclass:config = property(_playerc.player_ptz_req_generic_t_config_get, _playerc.player_ptz_req_generic_t_config_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ptz_req_generic_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ptz_req_generic_t
    __del__ = lambda self : None;
player_ptz_req_generic_t_swigregister = _playerc.player_ptz_req_generic_t_swigregister
player_ptz_req_generic_t_swigregister(player_ptz_req_generic_t)

class player_ptz_req_control_mode_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ptz_req_control_mode_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ptz_req_control_mode_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["mode"] = _playerc.player_ptz_req_control_mode_t_mode_set
    __swig_getmethods__["mode"] = _playerc.player_ptz_req_control_mode_t_mode_get
    if _newclass:mode = property(_playerc.player_ptz_req_control_mode_t_mode_get, _playerc.player_ptz_req_control_mode_t_mode_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ptz_req_control_mode_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ptz_req_control_mode_t
    __del__ = lambda self : None;
player_ptz_req_control_mode_t_swigregister = _playerc.player_ptz_req_control_mode_t_swigregister
player_ptz_req_control_mode_t_swigregister(player_ptz_req_control_mode_t)

PLAYER_AUDIO_CODE = _playerc.PLAYER_AUDIO_CODE
PLAYER_AUDIO_STRING = _playerc.PLAYER_AUDIO_STRING
PLAYER_AUDIO_DATA_WAV_REC = _playerc.PLAYER_AUDIO_DATA_WAV_REC
PLAYER_AUDIO_DATA_SEQ = _playerc.PLAYER_AUDIO_DATA_SEQ
PLAYER_AUDIO_DATA_MIXER_CHANNEL = _playerc.PLAYER_AUDIO_DATA_MIXER_CHANNEL
PLAYER_AUDIO_DATA_STATE = _playerc.PLAYER_AUDIO_DATA_STATE
PLAYER_AUDIO_CMD_WAV_PLAY = _playerc.PLAYER_AUDIO_CMD_WAV_PLAY
PLAYER_AUDIO_CMD_WAV_STREAM_REC = _playerc.PLAYER_AUDIO_CMD_WAV_STREAM_REC
PLAYER_AUDIO_CMD_SAMPLE_PLAY = _playerc.PLAYER_AUDIO_CMD_SAMPLE_PLAY
PLAYER_AUDIO_CMD_SEQ_PLAY = _playerc.PLAYER_AUDIO_CMD_SEQ_PLAY
PLAYER_AUDIO_CMD_MIXER_CHANNEL = _playerc.PLAYER_AUDIO_CMD_MIXER_CHANNEL
PLAYER_AUDIO_REQ_WAV_REC = _playerc.PLAYER_AUDIO_REQ_WAV_REC
PLAYER_AUDIO_REQ_SAMPLE_LOAD = _playerc.PLAYER_AUDIO_REQ_SAMPLE_LOAD
PLAYER_AUDIO_REQ_SAMPLE_RETRIEVE = _playerc.PLAYER_AUDIO_REQ_SAMPLE_RETRIEVE
PLAYER_AUDIO_REQ_SAMPLE_REC = _playerc.PLAYER_AUDIO_REQ_SAMPLE_REC
PLAYER_AUDIO_REQ_MIXER_CHANNEL_LIST = _playerc.PLAYER_AUDIO_REQ_MIXER_CHANNEL_LIST
PLAYER_AUDIO_REQ_MIXER_CHANNEL_LEVEL = _playerc.PLAYER_AUDIO_REQ_MIXER_CHANNEL_LEVEL
PLAYER_AUDIO_STATE_STOPPED = _playerc.PLAYER_AUDIO_STATE_STOPPED
PLAYER_AUDIO_STATE_PLAYING = _playerc.PLAYER_AUDIO_STATE_PLAYING
PLAYER_AUDIO_STATE_RECORDING = _playerc.PLAYER_AUDIO_STATE_RECORDING
PLAYER_AUDIO_DESCRIPTION_BITS = _playerc.PLAYER_AUDIO_DESCRIPTION_BITS
PLAYER_AUDIO_BITS = _playerc.PLAYER_AUDIO_BITS
PLAYER_AUDIO_8BIT = _playerc.PLAYER_AUDIO_8BIT
PLAYER_AUDIO_16BIT = _playerc.PLAYER_AUDIO_16BIT
PLAYER_AUDIO_24BIT = _playerc.PLAYER_AUDIO_24BIT
PLAYER_AUDIO_MONO = _playerc.PLAYER_AUDIO_MONO
PLAYER_AUDIO_STEREO = _playerc.PLAYER_AUDIO_STEREO
PLAYER_AUDIO_FREQ = _playerc.PLAYER_AUDIO_FREQ
PLAYER_AUDIO_FREQ_44k = _playerc.PLAYER_AUDIO_FREQ_44k
PLAYER_AUDIO_FREQ_11k = _playerc.PLAYER_AUDIO_FREQ_11k
PLAYER_AUDIO_FREQ_22k = _playerc.PLAYER_AUDIO_FREQ_22k
PLAYER_AUDIO_FREQ_48k = _playerc.PLAYER_AUDIO_FREQ_48k
PLAYER_AUDIO_FORMAT_BITS = _playerc.PLAYER_AUDIO_FORMAT_BITS
PLAYER_AUDIO_FORMAT_NULL = _playerc.PLAYER_AUDIO_FORMAT_NULL
PLAYER_AUDIO_FORMAT_RAW = _playerc.PLAYER_AUDIO_FORMAT_RAW
PLAYER_AUDIO_FORMAT_MP3 = _playerc.PLAYER_AUDIO_FORMAT_MP3
PLAYER_AUDIO_FORMAT_OGG = _playerc.PLAYER_AUDIO_FORMAT_OGG
PLAYER_AUDIO_FORMAT_FLAC = _playerc.PLAYER_AUDIO_FORMAT_FLAC
PLAYER_AUDIO_FORMAT_AAC = _playerc.PLAYER_AUDIO_FORMAT_AAC
class player_audio_wav_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_wav_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_wav_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["data_count"] = _playerc.player_audio_wav_t_data_count_set
    __swig_getmethods__["data_count"] = _playerc.player_audio_wav_t_data_count_get
    if _newclass:data_count = property(_playerc.player_audio_wav_t_data_count_get, _playerc.player_audio_wav_t_data_count_set)
    __swig_setmethods__["data"] = _playerc.player_audio_wav_t_data_set
    __swig_getmethods__["data"] = _playerc.player_audio_wav_t_data_get
    if _newclass:data = property(_playerc.player_audio_wav_t_data_get, _playerc.player_audio_wav_t_data_set)
    __swig_setmethods__["format"] = _playerc.player_audio_wav_t_format_set
    __swig_getmethods__["format"] = _playerc.player_audio_wav_t_format_get
    if _newclass:format = property(_playerc.player_audio_wav_t_format_get, _playerc.player_audio_wav_t_format_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_wav_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_wav_t
    __del__ = lambda self : None;
player_audio_wav_t_swigregister = _playerc.player_audio_wav_t_swigregister
player_audio_wav_t_swigregister(player_audio_wav_t)

class player_audio_seq_item_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_seq_item_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_seq_item_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["freq"] = _playerc.player_audio_seq_item_t_freq_set
    __swig_getmethods__["freq"] = _playerc.player_audio_seq_item_t_freq_get
    if _newclass:freq = property(_playerc.player_audio_seq_item_t_freq_get, _playerc.player_audio_seq_item_t_freq_set)
    __swig_setmethods__["duration"] = _playerc.player_audio_seq_item_t_duration_set
    __swig_getmethods__["duration"] = _playerc.player_audio_seq_item_t_duration_get
    if _newclass:duration = property(_playerc.player_audio_seq_item_t_duration_get, _playerc.player_audio_seq_item_t_duration_set)
    __swig_setmethods__["amplitude"] = _playerc.player_audio_seq_item_t_amplitude_set
    __swig_getmethods__["amplitude"] = _playerc.player_audio_seq_item_t_amplitude_get
    if _newclass:amplitude = property(_playerc.player_audio_seq_item_t_amplitude_get, _playerc.player_audio_seq_item_t_amplitude_set)
    __swig_setmethods__["link"] = _playerc.player_audio_seq_item_t_link_set
    __swig_getmethods__["link"] = _playerc.player_audio_seq_item_t_link_get
    if _newclass:link = property(_playerc.player_audio_seq_item_t_link_get, _playerc.player_audio_seq_item_t_link_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_seq_item_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_seq_item_t
    __del__ = lambda self : None;
player_audio_seq_item_t_swigregister = _playerc.player_audio_seq_item_t_swigregister
player_audio_seq_item_t_swigregister(player_audio_seq_item_t)

class player_audio_seq_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_seq_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_seq_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["tones_count"] = _playerc.player_audio_seq_t_tones_count_set
    __swig_getmethods__["tones_count"] = _playerc.player_audio_seq_t_tones_count_get
    if _newclass:tones_count = property(_playerc.player_audio_seq_t_tones_count_get, _playerc.player_audio_seq_t_tones_count_set)
    __swig_setmethods__["tones"] = _playerc.player_audio_seq_t_tones_set
    __swig_getmethods__["tones"] = _playerc.player_audio_seq_t_tones_get
    if _newclass:tones = property(_playerc.player_audio_seq_t_tones_get, _playerc.player_audio_seq_t_tones_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_seq_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_seq_t
    __del__ = lambda self : None;
player_audio_seq_t_swigregister = _playerc.player_audio_seq_t_swigregister
player_audio_seq_t_swigregister(player_audio_seq_t)

class player_audio_mixer_channel_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_mixer_channel_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_mixer_channel_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["amplitude"] = _playerc.player_audio_mixer_channel_t_amplitude_set
    __swig_getmethods__["amplitude"] = _playerc.player_audio_mixer_channel_t_amplitude_get
    if _newclass:amplitude = property(_playerc.player_audio_mixer_channel_t_amplitude_get, _playerc.player_audio_mixer_channel_t_amplitude_set)
    __swig_setmethods__["active"] = _playerc.player_audio_mixer_channel_t_active_set
    __swig_getmethods__["active"] = _playerc.player_audio_mixer_channel_t_active_get
    if _newclass:active = property(_playerc.player_audio_mixer_channel_t_active_get, _playerc.player_audio_mixer_channel_t_active_set)
    __swig_setmethods__["index"] = _playerc.player_audio_mixer_channel_t_index_set
    __swig_getmethods__["index"] = _playerc.player_audio_mixer_channel_t_index_get
    if _newclass:index = property(_playerc.player_audio_mixer_channel_t_index_get, _playerc.player_audio_mixer_channel_t_index_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_mixer_channel_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_mixer_channel_t
    __del__ = lambda self : None;
player_audio_mixer_channel_t_swigregister = _playerc.player_audio_mixer_channel_t_swigregister
player_audio_mixer_channel_t_swigregister(player_audio_mixer_channel_t)

class player_audio_mixer_channel_list_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_mixer_channel_list_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_mixer_channel_list_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["channels_count"] = _playerc.player_audio_mixer_channel_list_t_channels_count_set
    __swig_getmethods__["channels_count"] = _playerc.player_audio_mixer_channel_list_t_channels_count_get
    if _newclass:channels_count = property(_playerc.player_audio_mixer_channel_list_t_channels_count_get, _playerc.player_audio_mixer_channel_list_t_channels_count_set)
    __swig_setmethods__["channels"] = _playerc.player_audio_mixer_channel_list_t_channels_set
    __swig_getmethods__["channels"] = _playerc.player_audio_mixer_channel_list_t_channels_get
    if _newclass:channels = property(_playerc.player_audio_mixer_channel_list_t_channels_get, _playerc.player_audio_mixer_channel_list_t_channels_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_mixer_channel_list_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_mixer_channel_list_t
    __del__ = lambda self : None;
player_audio_mixer_channel_list_t_swigregister = _playerc.player_audio_mixer_channel_list_t_swigregister
player_audio_mixer_channel_list_t_swigregister(player_audio_mixer_channel_list_t)

PLAYER_AUDIO_MIXER_CHANNEL_TYPE_INPUT = _playerc.PLAYER_AUDIO_MIXER_CHANNEL_TYPE_INPUT
PLAYER_AUDIO_MIXER_CHANNEL_TYPE_OUTPUT = _playerc.PLAYER_AUDIO_MIXER_CHANNEL_TYPE_OUTPUT
PLAYER_AUDIO_MIXER_CHANNEL_TYPE_SPECIAL = _playerc.PLAYER_AUDIO_MIXER_CHANNEL_TYPE_SPECIAL
class player_audio_mixer_channel_detail_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_mixer_channel_detail_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_mixer_channel_detail_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["name_count"] = _playerc.player_audio_mixer_channel_detail_t_name_count_set
    __swig_getmethods__["name_count"] = _playerc.player_audio_mixer_channel_detail_t_name_count_get
    if _newclass:name_count = property(_playerc.player_audio_mixer_channel_detail_t_name_count_get, _playerc.player_audio_mixer_channel_detail_t_name_count_set)
    __swig_setmethods__["name"] = _playerc.player_audio_mixer_channel_detail_t_name_set
    __swig_getmethods__["name"] = _playerc.player_audio_mixer_channel_detail_t_name_get
    if _newclass:name = property(_playerc.player_audio_mixer_channel_detail_t_name_get, _playerc.player_audio_mixer_channel_detail_t_name_set)
    __swig_setmethods__["caps"] = _playerc.player_audio_mixer_channel_detail_t_caps_set
    __swig_getmethods__["caps"] = _playerc.player_audio_mixer_channel_detail_t_caps_get
    if _newclass:caps = property(_playerc.player_audio_mixer_channel_detail_t_caps_get, _playerc.player_audio_mixer_channel_detail_t_caps_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_mixer_channel_detail_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_mixer_channel_detail_t
    __del__ = lambda self : None;
player_audio_mixer_channel_detail_t_swigregister = _playerc.player_audio_mixer_channel_detail_t_swigregister
player_audio_mixer_channel_detail_t_swigregister(player_audio_mixer_channel_detail_t)

class player_audio_mixer_channel_list_detail_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_mixer_channel_list_detail_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_mixer_channel_list_detail_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["details_count"] = _playerc.player_audio_mixer_channel_list_detail_t_details_count_set
    __swig_getmethods__["details_count"] = _playerc.player_audio_mixer_channel_list_detail_t_details_count_get
    if _newclass:details_count = property(_playerc.player_audio_mixer_channel_list_detail_t_details_count_get, _playerc.player_audio_mixer_channel_list_detail_t_details_count_set)
    __swig_setmethods__["details"] = _playerc.player_audio_mixer_channel_list_detail_t_details_set
    __swig_getmethods__["details"] = _playerc.player_audio_mixer_channel_list_detail_t_details_get
    if _newclass:details = property(_playerc.player_audio_mixer_channel_list_detail_t_details_get, _playerc.player_audio_mixer_channel_list_detail_t_details_set)
    __swig_setmethods__["default_output"] = _playerc.player_audio_mixer_channel_list_detail_t_default_output_set
    __swig_getmethods__["default_output"] = _playerc.player_audio_mixer_channel_list_detail_t_default_output_get
    if _newclass:default_output = property(_playerc.player_audio_mixer_channel_list_detail_t_default_output_get, _playerc.player_audio_mixer_channel_list_detail_t_default_output_set)
    __swig_setmethods__["default_input"] = _playerc.player_audio_mixer_channel_list_detail_t_default_input_set
    __swig_getmethods__["default_input"] = _playerc.player_audio_mixer_channel_list_detail_t_default_input_get
    if _newclass:default_input = property(_playerc.player_audio_mixer_channel_list_detail_t_default_input_get, _playerc.player_audio_mixer_channel_list_detail_t_default_input_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_mixer_channel_list_detail_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_mixer_channel_list_detail_t
    __del__ = lambda self : None;
player_audio_mixer_channel_list_detail_t_swigregister = _playerc.player_audio_mixer_channel_list_detail_t_swigregister
player_audio_mixer_channel_list_detail_t_swigregister(player_audio_mixer_channel_list_detail_t)

class player_audio_sample_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_sample_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_sample_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["sample"] = _playerc.player_audio_sample_t_sample_set
    __swig_getmethods__["sample"] = _playerc.player_audio_sample_t_sample_get
    if _newclass:sample = property(_playerc.player_audio_sample_t_sample_get, _playerc.player_audio_sample_t_sample_set)
    __swig_setmethods__["index"] = _playerc.player_audio_sample_t_index_set
    __swig_getmethods__["index"] = _playerc.player_audio_sample_t_index_get
    if _newclass:index = property(_playerc.player_audio_sample_t_index_get, _playerc.player_audio_sample_t_index_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_sample_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_sample_t
    __del__ = lambda self : None;
player_audio_sample_t_swigregister = _playerc.player_audio_sample_t_swigregister
player_audio_sample_t_swigregister(player_audio_sample_t)

class player_audio_sample_item_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_sample_item_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_sample_item_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["index"] = _playerc.player_audio_sample_item_t_index_set
    __swig_getmethods__["index"] = _playerc.player_audio_sample_item_t_index_get
    if _newclass:index = property(_playerc.player_audio_sample_item_t_index_get, _playerc.player_audio_sample_item_t_index_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_sample_item_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_sample_item_t
    __del__ = lambda self : None;
player_audio_sample_item_t_swigregister = _playerc.player_audio_sample_item_t_swigregister
player_audio_sample_item_t_swigregister(player_audio_sample_item_t)

class player_audio_sample_rec_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_sample_rec_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_sample_rec_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["index"] = _playerc.player_audio_sample_rec_req_t_index_set
    __swig_getmethods__["index"] = _playerc.player_audio_sample_rec_req_t_index_get
    if _newclass:index = property(_playerc.player_audio_sample_rec_req_t_index_get, _playerc.player_audio_sample_rec_req_t_index_set)
    __swig_setmethods__["length"] = _playerc.player_audio_sample_rec_req_t_length_set
    __swig_getmethods__["length"] = _playerc.player_audio_sample_rec_req_t_length_get
    if _newclass:length = property(_playerc.player_audio_sample_rec_req_t_length_get, _playerc.player_audio_sample_rec_req_t_length_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_sample_rec_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_sample_rec_req_t
    __del__ = lambda self : None;
player_audio_sample_rec_req_t_swigregister = _playerc.player_audio_sample_rec_req_t_swigregister
player_audio_sample_rec_req_t_swigregister(player_audio_sample_rec_req_t)

class player_audio_state_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_audio_state_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_audio_state_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_audio_state_t_state_set
    __swig_getmethods__["state"] = _playerc.player_audio_state_t_state_get
    if _newclass:state = property(_playerc.player_audio_state_t_state_get, _playerc.player_audio_state_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_audio_state_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_audio_state_t
    __del__ = lambda self : None;
player_audio_state_t_swigregister = _playerc.player_audio_state_t_swigregister
player_audio_state_t_swigregister(player_audio_state_t)

PLAYER_FIDUCIAL_CODE = _playerc.PLAYER_FIDUCIAL_CODE
PLAYER_FIDUCIAL_STRING = _playerc.PLAYER_FIDUCIAL_STRING
PLAYER_FIDUCIAL_DATA_SCAN = _playerc.PLAYER_FIDUCIAL_DATA_SCAN
PLAYER_FIDUCIAL_REQ_GET_GEOM = _playerc.PLAYER_FIDUCIAL_REQ_GET_GEOM
PLAYER_FIDUCIAL_REQ_GET_FOV = _playerc.PLAYER_FIDUCIAL_REQ_GET_FOV
PLAYER_FIDUCIAL_REQ_SET_FOV = _playerc.PLAYER_FIDUCIAL_REQ_SET_FOV
PLAYER_FIDUCIAL_REQ_GET_ID = _playerc.PLAYER_FIDUCIAL_REQ_GET_ID
PLAYER_FIDUCIAL_REQ_SET_ID = _playerc.PLAYER_FIDUCIAL_REQ_SET_ID
class player_fiducial_item_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_fiducial_item_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_fiducial_item_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["id"] = _playerc.player_fiducial_item_t_id_set
    __swig_getmethods__["id"] = _playerc.player_fiducial_item_t_id_get
    if _newclass:id = property(_playerc.player_fiducial_item_t_id_get, _playerc.player_fiducial_item_t_id_set)
    __swig_setmethods__["pose"] = _playerc.player_fiducial_item_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_fiducial_item_t_pose_get
    if _newclass:pose = property(_playerc.player_fiducial_item_t_pose_get, _playerc.player_fiducial_item_t_pose_set)
    __swig_setmethods__["upose"] = _playerc.player_fiducial_item_t_upose_set
    __swig_getmethods__["upose"] = _playerc.player_fiducial_item_t_upose_get
    if _newclass:upose = property(_playerc.player_fiducial_item_t_upose_get, _playerc.player_fiducial_item_t_upose_set)
    def __init__(self, *args): 
        this = _playerc.new_player_fiducial_item_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_fiducial_item_t
    __del__ = lambda self : None;
player_fiducial_item_t_swigregister = _playerc.player_fiducial_item_t_swigregister
player_fiducial_item_t_swigregister(player_fiducial_item_t)

class player_fiducial_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_fiducial_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_fiducial_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["fiducials_count"] = _playerc.player_fiducial_data_t_fiducials_count_set
    __swig_getmethods__["fiducials_count"] = _playerc.player_fiducial_data_t_fiducials_count_get
    if _newclass:fiducials_count = property(_playerc.player_fiducial_data_t_fiducials_count_get, _playerc.player_fiducial_data_t_fiducials_count_set)
    __swig_setmethods__["fiducials"] = _playerc.player_fiducial_data_t_fiducials_set
    __swig_getmethods__["fiducials"] = _playerc.player_fiducial_data_t_fiducials_get
    if _newclass:fiducials = property(_playerc.player_fiducial_data_t_fiducials_get, _playerc.player_fiducial_data_t_fiducials_set)
    def __init__(self, *args): 
        this = _playerc.new_player_fiducial_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_fiducial_data_t
    __del__ = lambda self : None;
player_fiducial_data_t_swigregister = _playerc.player_fiducial_data_t_swigregister
player_fiducial_data_t_swigregister(player_fiducial_data_t)

class player_fiducial_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_fiducial_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_fiducial_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_fiducial_geom_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_fiducial_geom_t_pose_get
    if _newclass:pose = property(_playerc.player_fiducial_geom_t_pose_get, _playerc.player_fiducial_geom_t_pose_set)
    __swig_setmethods__["size"] = _playerc.player_fiducial_geom_t_size_set
    __swig_getmethods__["size"] = _playerc.player_fiducial_geom_t_size_get
    if _newclass:size = property(_playerc.player_fiducial_geom_t_size_get, _playerc.player_fiducial_geom_t_size_set)
    __swig_setmethods__["fiducial_size"] = _playerc.player_fiducial_geom_t_fiducial_size_set
    __swig_getmethods__["fiducial_size"] = _playerc.player_fiducial_geom_t_fiducial_size_get
    if _newclass:fiducial_size = property(_playerc.player_fiducial_geom_t_fiducial_size_get, _playerc.player_fiducial_geom_t_fiducial_size_set)
    def __init__(self, *args): 
        this = _playerc.new_player_fiducial_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_fiducial_geom_t
    __del__ = lambda self : None;
player_fiducial_geom_t_swigregister = _playerc.player_fiducial_geom_t_swigregister
player_fiducial_geom_t_swigregister(player_fiducial_geom_t)

class player_fiducial_fov_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_fiducial_fov_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_fiducial_fov_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["min_range"] = _playerc.player_fiducial_fov_t_min_range_set
    __swig_getmethods__["min_range"] = _playerc.player_fiducial_fov_t_min_range_get
    if _newclass:min_range = property(_playerc.player_fiducial_fov_t_min_range_get, _playerc.player_fiducial_fov_t_min_range_set)
    __swig_setmethods__["max_range"] = _playerc.player_fiducial_fov_t_max_range_set
    __swig_getmethods__["max_range"] = _playerc.player_fiducial_fov_t_max_range_get
    if _newclass:max_range = property(_playerc.player_fiducial_fov_t_max_range_get, _playerc.player_fiducial_fov_t_max_range_set)
    __swig_setmethods__["view_angle"] = _playerc.player_fiducial_fov_t_view_angle_set
    __swig_getmethods__["view_angle"] = _playerc.player_fiducial_fov_t_view_angle_get
    if _newclass:view_angle = property(_playerc.player_fiducial_fov_t_view_angle_get, _playerc.player_fiducial_fov_t_view_angle_set)
    def __init__(self, *args): 
        this = _playerc.new_player_fiducial_fov_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_fiducial_fov_t
    __del__ = lambda self : None;
player_fiducial_fov_t_swigregister = _playerc.player_fiducial_fov_t_swigregister
player_fiducial_fov_t_swigregister(player_fiducial_fov_t)

class player_fiducial_id_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_fiducial_id_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_fiducial_id_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["id"] = _playerc.player_fiducial_id_t_id_set
    __swig_getmethods__["id"] = _playerc.player_fiducial_id_t_id_get
    if _newclass:id = property(_playerc.player_fiducial_id_t_id_get, _playerc.player_fiducial_id_t_id_set)
    def __init__(self, *args): 
        this = _playerc.new_player_fiducial_id_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_fiducial_id_t
    __del__ = lambda self : None;
player_fiducial_id_t_swigregister = _playerc.player_fiducial_id_t_swigregister
player_fiducial_id_t_swigregister(player_fiducial_id_t)

PLAYER_SPEECH_CODE = _playerc.PLAYER_SPEECH_CODE
PLAYER_SPEECH_STRING = _playerc.PLAYER_SPEECH_STRING
PLAYER_SPEECH_CMD_SAY = _playerc.PLAYER_SPEECH_CMD_SAY
class player_speech_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_speech_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_speech_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["string_count"] = _playerc.player_speech_cmd_t_string_count_set
    __swig_getmethods__["string_count"] = _playerc.player_speech_cmd_t_string_count_get
    if _newclass:string_count = property(_playerc.player_speech_cmd_t_string_count_get, _playerc.player_speech_cmd_t_string_count_set)
    __swig_setmethods__["string"] = _playerc.player_speech_cmd_t_string_set
    __swig_getmethods__["string"] = _playerc.player_speech_cmd_t_string_get
    if _newclass:string = property(_playerc.player_speech_cmd_t_string_get, _playerc.player_speech_cmd_t_string_set)
    def __init__(self, *args): 
        this = _playerc.new_player_speech_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_speech_cmd_t
    __del__ = lambda self : None;
player_speech_cmd_t_swigregister = _playerc.player_speech_cmd_t_swigregister
player_speech_cmd_t_swigregister(player_speech_cmd_t)

PLAYER_GPS_CODE = _playerc.PLAYER_GPS_CODE
PLAYER_GPS_STRING = _playerc.PLAYER_GPS_STRING
PLAYER_GPS_DATA_STATE = _playerc.PLAYER_GPS_DATA_STATE
class player_gps_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_gps_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_gps_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["time_sec"] = _playerc.player_gps_data_t_time_sec_set
    __swig_getmethods__["time_sec"] = _playerc.player_gps_data_t_time_sec_get
    if _newclass:time_sec = property(_playerc.player_gps_data_t_time_sec_get, _playerc.player_gps_data_t_time_sec_set)
    __swig_setmethods__["time_usec"] = _playerc.player_gps_data_t_time_usec_set
    __swig_getmethods__["time_usec"] = _playerc.player_gps_data_t_time_usec_get
    if _newclass:time_usec = property(_playerc.player_gps_data_t_time_usec_get, _playerc.player_gps_data_t_time_usec_set)
    __swig_setmethods__["latitude"] = _playerc.player_gps_data_t_latitude_set
    __swig_getmethods__["latitude"] = _playerc.player_gps_data_t_latitude_get
    if _newclass:latitude = property(_playerc.player_gps_data_t_latitude_get, _playerc.player_gps_data_t_latitude_set)
    __swig_setmethods__["longitude"] = _playerc.player_gps_data_t_longitude_set
    __swig_getmethods__["longitude"] = _playerc.player_gps_data_t_longitude_get
    if _newclass:longitude = property(_playerc.player_gps_data_t_longitude_get, _playerc.player_gps_data_t_longitude_set)
    __swig_setmethods__["altitude"] = _playerc.player_gps_data_t_altitude_set
    __swig_getmethods__["altitude"] = _playerc.player_gps_data_t_altitude_get
    if _newclass:altitude = property(_playerc.player_gps_data_t_altitude_get, _playerc.player_gps_data_t_altitude_set)
    __swig_setmethods__["utm_e"] = _playerc.player_gps_data_t_utm_e_set
    __swig_getmethods__["utm_e"] = _playerc.player_gps_data_t_utm_e_get
    if _newclass:utm_e = property(_playerc.player_gps_data_t_utm_e_get, _playerc.player_gps_data_t_utm_e_set)
    __swig_setmethods__["utm_n"] = _playerc.player_gps_data_t_utm_n_set
    __swig_getmethods__["utm_n"] = _playerc.player_gps_data_t_utm_n_get
    if _newclass:utm_n = property(_playerc.player_gps_data_t_utm_n_get, _playerc.player_gps_data_t_utm_n_set)
    __swig_setmethods__["quality"] = _playerc.player_gps_data_t_quality_set
    __swig_getmethods__["quality"] = _playerc.player_gps_data_t_quality_get
    if _newclass:quality = property(_playerc.player_gps_data_t_quality_get, _playerc.player_gps_data_t_quality_set)
    __swig_setmethods__["num_sats"] = _playerc.player_gps_data_t_num_sats_set
    __swig_getmethods__["num_sats"] = _playerc.player_gps_data_t_num_sats_get
    if _newclass:num_sats = property(_playerc.player_gps_data_t_num_sats_get, _playerc.player_gps_data_t_num_sats_set)
    __swig_setmethods__["hdop"] = _playerc.player_gps_data_t_hdop_set
    __swig_getmethods__["hdop"] = _playerc.player_gps_data_t_hdop_get
    if _newclass:hdop = property(_playerc.player_gps_data_t_hdop_get, _playerc.player_gps_data_t_hdop_set)
    __swig_setmethods__["vdop"] = _playerc.player_gps_data_t_vdop_set
    __swig_getmethods__["vdop"] = _playerc.player_gps_data_t_vdop_get
    if _newclass:vdop = property(_playerc.player_gps_data_t_vdop_get, _playerc.player_gps_data_t_vdop_set)
    __swig_setmethods__["err_horz"] = _playerc.player_gps_data_t_err_horz_set
    __swig_getmethods__["err_horz"] = _playerc.player_gps_data_t_err_horz_get
    if _newclass:err_horz = property(_playerc.player_gps_data_t_err_horz_get, _playerc.player_gps_data_t_err_horz_set)
    __swig_setmethods__["err_vert"] = _playerc.player_gps_data_t_err_vert_set
    __swig_getmethods__["err_vert"] = _playerc.player_gps_data_t_err_vert_get
    if _newclass:err_vert = property(_playerc.player_gps_data_t_err_vert_get, _playerc.player_gps_data_t_err_vert_set)
    def __init__(self, *args): 
        this = _playerc.new_player_gps_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_gps_data_t
    __del__ = lambda self : None;
player_gps_data_t_swigregister = _playerc.player_gps_data_t_swigregister
player_gps_data_t_swigregister(player_gps_data_t)

PLAYER_BUMPER_CODE = _playerc.PLAYER_BUMPER_CODE
PLAYER_BUMPER_STRING = _playerc.PLAYER_BUMPER_STRING
PLAYER_BUMPER_DATA_STATE = _playerc.PLAYER_BUMPER_DATA_STATE
PLAYER_BUMPER_DATA_GEOM = _playerc.PLAYER_BUMPER_DATA_GEOM
PLAYER_BUMPER_REQ_GET_GEOM = _playerc.PLAYER_BUMPER_REQ_GET_GEOM
class player_bumper_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_bumper_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_bumper_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["bumpers_count"] = _playerc.player_bumper_data_t_bumpers_count_set
    __swig_getmethods__["bumpers_count"] = _playerc.player_bumper_data_t_bumpers_count_get
    if _newclass:bumpers_count = property(_playerc.player_bumper_data_t_bumpers_count_get, _playerc.player_bumper_data_t_bumpers_count_set)
    __swig_setmethods__["bumpers"] = _playerc.player_bumper_data_t_bumpers_set
    __swig_getmethods__["bumpers"] = _playerc.player_bumper_data_t_bumpers_get
    if _newclass:bumpers = property(_playerc.player_bumper_data_t_bumpers_get, _playerc.player_bumper_data_t_bumpers_set)
    def __init__(self, *args): 
        this = _playerc.new_player_bumper_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_bumper_data_t
    __del__ = lambda self : None;
player_bumper_data_t_swigregister = _playerc.player_bumper_data_t_swigregister
player_bumper_data_t_swigregister(player_bumper_data_t)

class player_bumper_define_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_bumper_define_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_bumper_define_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_bumper_define_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_bumper_define_t_pose_get
    if _newclass:pose = property(_playerc.player_bumper_define_t_pose_get, _playerc.player_bumper_define_t_pose_set)
    __swig_setmethods__["length"] = _playerc.player_bumper_define_t_length_set
    __swig_getmethods__["length"] = _playerc.player_bumper_define_t_length_get
    if _newclass:length = property(_playerc.player_bumper_define_t_length_get, _playerc.player_bumper_define_t_length_set)
    __swig_setmethods__["radius"] = _playerc.player_bumper_define_t_radius_set
    __swig_getmethods__["radius"] = _playerc.player_bumper_define_t_radius_get
    if _newclass:radius = property(_playerc.player_bumper_define_t_radius_get, _playerc.player_bumper_define_t_radius_set)
    def __init__(self, *args): 
        this = _playerc.new_player_bumper_define_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_bumper_define_t
    __del__ = lambda self : None;
player_bumper_define_t_swigregister = _playerc.player_bumper_define_t_swigregister
player_bumper_define_t_swigregister(player_bumper_define_t)

class player_bumper_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_bumper_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_bumper_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["bumper_def_count"] = _playerc.player_bumper_geom_t_bumper_def_count_set
    __swig_getmethods__["bumper_def_count"] = _playerc.player_bumper_geom_t_bumper_def_count_get
    if _newclass:bumper_def_count = property(_playerc.player_bumper_geom_t_bumper_def_count_get, _playerc.player_bumper_geom_t_bumper_def_count_set)
    __swig_setmethods__["bumper_def"] = _playerc.player_bumper_geom_t_bumper_def_set
    __swig_getmethods__["bumper_def"] = _playerc.player_bumper_geom_t_bumper_def_get
    if _newclass:bumper_def = property(_playerc.player_bumper_geom_t_bumper_def_get, _playerc.player_bumper_geom_t_bumper_def_set)
    def __init__(self, *args): 
        this = _playerc.new_player_bumper_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_bumper_geom_t
    __del__ = lambda self : None;
player_bumper_geom_t_swigregister = _playerc.player_bumper_geom_t_swigregister
player_bumper_geom_t_swigregister(player_bumper_geom_t)

PLAYER_DIO_CODE = _playerc.PLAYER_DIO_CODE
PLAYER_DIO_STRING = _playerc.PLAYER_DIO_STRING
PLAYER_DIO_DATA_VALUES = _playerc.PLAYER_DIO_DATA_VALUES
PLAYER_DIO_CMD_VALUES = _playerc.PLAYER_DIO_CMD_VALUES
class player_dio_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_dio_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_dio_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["count"] = _playerc.player_dio_data_t_count_set
    __swig_getmethods__["count"] = _playerc.player_dio_data_t_count_get
    if _newclass:count = property(_playerc.player_dio_data_t_count_get, _playerc.player_dio_data_t_count_set)
    __swig_setmethods__["bits"] = _playerc.player_dio_data_t_bits_set
    __swig_getmethods__["bits"] = _playerc.player_dio_data_t_bits_get
    if _newclass:bits = property(_playerc.player_dio_data_t_bits_get, _playerc.player_dio_data_t_bits_set)
    def __init__(self, *args): 
        this = _playerc.new_player_dio_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_dio_data_t
    __del__ = lambda self : None;
player_dio_data_t_swigregister = _playerc.player_dio_data_t_swigregister
player_dio_data_t_swigregister(player_dio_data_t)

class player_dio_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_dio_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_dio_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["count"] = _playerc.player_dio_cmd_t_count_set
    __swig_getmethods__["count"] = _playerc.player_dio_cmd_t_count_get
    if _newclass:count = property(_playerc.player_dio_cmd_t_count_get, _playerc.player_dio_cmd_t_count_set)
    __swig_setmethods__["digout"] = _playerc.player_dio_cmd_t_digout_set
    __swig_getmethods__["digout"] = _playerc.player_dio_cmd_t_digout_get
    if _newclass:digout = property(_playerc.player_dio_cmd_t_digout_get, _playerc.player_dio_cmd_t_digout_set)
    def __init__(self, *args): 
        this = _playerc.new_player_dio_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_dio_cmd_t
    __del__ = lambda self : None;
player_dio_cmd_t_swigregister = _playerc.player_dio_cmd_t_swigregister
player_dio_cmd_t_swigregister(player_dio_cmd_t)

PLAYER_AIO_CODE = _playerc.PLAYER_AIO_CODE
PLAYER_AIO_STRING = _playerc.PLAYER_AIO_STRING
PLAYER_AIO_CMD_STATE = _playerc.PLAYER_AIO_CMD_STATE
PLAYER_AIO_DATA_STATE = _playerc.PLAYER_AIO_DATA_STATE
class player_aio_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_aio_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_aio_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["voltages_count"] = _playerc.player_aio_data_t_voltages_count_set
    __swig_getmethods__["voltages_count"] = _playerc.player_aio_data_t_voltages_count_get
    if _newclass:voltages_count = property(_playerc.player_aio_data_t_voltages_count_get, _playerc.player_aio_data_t_voltages_count_set)
    __swig_setmethods__["voltages"] = _playerc.player_aio_data_t_voltages_set
    __swig_getmethods__["voltages"] = _playerc.player_aio_data_t_voltages_get
    if _newclass:voltages = property(_playerc.player_aio_data_t_voltages_get, _playerc.player_aio_data_t_voltages_set)
    def __init__(self, *args): 
        this = _playerc.new_player_aio_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_aio_data_t
    __del__ = lambda self : None;
player_aio_data_t_swigregister = _playerc.player_aio_data_t_swigregister
player_aio_data_t_swigregister(player_aio_data_t)

class player_aio_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_aio_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_aio_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["id"] = _playerc.player_aio_cmd_t_id_set
    __swig_getmethods__["id"] = _playerc.player_aio_cmd_t_id_get
    if _newclass:id = property(_playerc.player_aio_cmd_t_id_get, _playerc.player_aio_cmd_t_id_set)
    __swig_setmethods__["voltage"] = _playerc.player_aio_cmd_t_voltage_set
    __swig_getmethods__["voltage"] = _playerc.player_aio_cmd_t_voltage_get
    if _newclass:voltage = property(_playerc.player_aio_cmd_t_voltage_get, _playerc.player_aio_cmd_t_voltage_set)
    def __init__(self, *args): 
        this = _playerc.new_player_aio_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_aio_cmd_t
    __del__ = lambda self : None;
player_aio_cmd_t_swigregister = _playerc.player_aio_cmd_t_swigregister
player_aio_cmd_t_swigregister(player_aio_cmd_t)

PLAYER_IR_CODE = _playerc.PLAYER_IR_CODE
PLAYER_IR_STRING = _playerc.PLAYER_IR_STRING
PLAYER_IR_REQ_POSE = _playerc.PLAYER_IR_REQ_POSE
PLAYER_IR_REQ_POWER = _playerc.PLAYER_IR_REQ_POWER
PLAYER_IR_DATA_RANGES = _playerc.PLAYER_IR_DATA_RANGES
class player_ir_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ir_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ir_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["voltages_count"] = _playerc.player_ir_data_t_voltages_count_set
    __swig_getmethods__["voltages_count"] = _playerc.player_ir_data_t_voltages_count_get
    if _newclass:voltages_count = property(_playerc.player_ir_data_t_voltages_count_get, _playerc.player_ir_data_t_voltages_count_set)
    __swig_setmethods__["voltages"] = _playerc.player_ir_data_t_voltages_set
    __swig_getmethods__["voltages"] = _playerc.player_ir_data_t_voltages_get
    if _newclass:voltages = property(_playerc.player_ir_data_t_voltages_get, _playerc.player_ir_data_t_voltages_set)
    __swig_setmethods__["ranges_count"] = _playerc.player_ir_data_t_ranges_count_set
    __swig_getmethods__["ranges_count"] = _playerc.player_ir_data_t_ranges_count_get
    if _newclass:ranges_count = property(_playerc.player_ir_data_t_ranges_count_get, _playerc.player_ir_data_t_ranges_count_set)
    __swig_setmethods__["ranges"] = _playerc.player_ir_data_t_ranges_set
    __swig_getmethods__["ranges"] = _playerc.player_ir_data_t_ranges_get
    if _newclass:ranges = property(_playerc.player_ir_data_t_ranges_get, _playerc.player_ir_data_t_ranges_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ir_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ir_data_t
    __del__ = lambda self : None;
player_ir_data_t_swigregister = _playerc.player_ir_data_t_swigregister
player_ir_data_t_swigregister(player_ir_data_t)

class player_ir_pose_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ir_pose_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ir_pose_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["poses_count"] = _playerc.player_ir_pose_t_poses_count_set
    __swig_getmethods__["poses_count"] = _playerc.player_ir_pose_t_poses_count_get
    if _newclass:poses_count = property(_playerc.player_ir_pose_t_poses_count_get, _playerc.player_ir_pose_t_poses_count_set)
    __swig_setmethods__["poses"] = _playerc.player_ir_pose_t_poses_set
    __swig_getmethods__["poses"] = _playerc.player_ir_pose_t_poses_get
    if _newclass:poses = property(_playerc.player_ir_pose_t_poses_get, _playerc.player_ir_pose_t_poses_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ir_pose_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ir_pose_t
    __del__ = lambda self : None;
player_ir_pose_t_swigregister = _playerc.player_ir_pose_t_swigregister
player_ir_pose_t_swigregister(player_ir_pose_t)

class player_ir_power_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ir_power_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ir_power_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_ir_power_req_t_state_set
    __swig_getmethods__["state"] = _playerc.player_ir_power_req_t_state_get
    if _newclass:state = property(_playerc.player_ir_power_req_t_state_get, _playerc.player_ir_power_req_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ir_power_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ir_power_req_t
    __del__ = lambda self : None;
player_ir_power_req_t_swigregister = _playerc.player_ir_power_req_t_swigregister
player_ir_power_req_t_swigregister(player_ir_power_req_t)

PLAYER_WIFI_CODE = _playerc.PLAYER_WIFI_CODE
PLAYER_WIFI_STRING = _playerc.PLAYER_WIFI_STRING
PLAYER_WIFI_REQ_MAC = _playerc.PLAYER_WIFI_REQ_MAC
PLAYER_WIFI_REQ_IWSPY_ADD = _playerc.PLAYER_WIFI_REQ_IWSPY_ADD
PLAYER_WIFI_REQ_IWSPY_DEL = _playerc.PLAYER_WIFI_REQ_IWSPY_DEL
PLAYER_WIFI_REQ_IWSPY_PING = _playerc.PLAYER_WIFI_REQ_IWSPY_PING
PLAYER_WIFI_DATA_STATE = _playerc.PLAYER_WIFI_DATA_STATE
PLAYER_WIFI_QUAL_DBM = _playerc.PLAYER_WIFI_QUAL_DBM
PLAYER_WIFI_QUAL_REL = _playerc.PLAYER_WIFI_QUAL_REL
PLAYER_WIFI_QUAL_UNKNOWN = _playerc.PLAYER_WIFI_QUAL_UNKNOWN
PLAYER_WIFI_MODE_UNKNOWN = _playerc.PLAYER_WIFI_MODE_UNKNOWN
PLAYER_WIFI_MODE_AUTO = _playerc.PLAYER_WIFI_MODE_AUTO
PLAYER_WIFI_MODE_ADHOC = _playerc.PLAYER_WIFI_MODE_ADHOC
PLAYER_WIFI_MODE_INFRA = _playerc.PLAYER_WIFI_MODE_INFRA
PLAYER_WIFI_MODE_MASTER = _playerc.PLAYER_WIFI_MODE_MASTER
PLAYER_WIFI_MODE_REPEAT = _playerc.PLAYER_WIFI_MODE_REPEAT
PLAYER_WIFI_MODE_SECOND = _playerc.PLAYER_WIFI_MODE_SECOND
class player_wifi_link_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_wifi_link_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_wifi_link_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["mac_count"] = _playerc.player_wifi_link_t_mac_count_set
    __swig_getmethods__["mac_count"] = _playerc.player_wifi_link_t_mac_count_get
    if _newclass:mac_count = property(_playerc.player_wifi_link_t_mac_count_get, _playerc.player_wifi_link_t_mac_count_set)
    __swig_setmethods__["mac"] = _playerc.player_wifi_link_t_mac_set
    __swig_getmethods__["mac"] = _playerc.player_wifi_link_t_mac_get
    if _newclass:mac = property(_playerc.player_wifi_link_t_mac_get, _playerc.player_wifi_link_t_mac_set)
    __swig_setmethods__["ip_count"] = _playerc.player_wifi_link_t_ip_count_set
    __swig_getmethods__["ip_count"] = _playerc.player_wifi_link_t_ip_count_get
    if _newclass:ip_count = property(_playerc.player_wifi_link_t_ip_count_get, _playerc.player_wifi_link_t_ip_count_set)
    __swig_setmethods__["ip"] = _playerc.player_wifi_link_t_ip_set
    __swig_getmethods__["ip"] = _playerc.player_wifi_link_t_ip_get
    if _newclass:ip = property(_playerc.player_wifi_link_t_ip_get, _playerc.player_wifi_link_t_ip_set)
    __swig_setmethods__["essid_count"] = _playerc.player_wifi_link_t_essid_count_set
    __swig_getmethods__["essid_count"] = _playerc.player_wifi_link_t_essid_count_get
    if _newclass:essid_count = property(_playerc.player_wifi_link_t_essid_count_get, _playerc.player_wifi_link_t_essid_count_set)
    __swig_setmethods__["essid"] = _playerc.player_wifi_link_t_essid_set
    __swig_getmethods__["essid"] = _playerc.player_wifi_link_t_essid_get
    if _newclass:essid = property(_playerc.player_wifi_link_t_essid_get, _playerc.player_wifi_link_t_essid_set)
    __swig_setmethods__["mode"] = _playerc.player_wifi_link_t_mode_set
    __swig_getmethods__["mode"] = _playerc.player_wifi_link_t_mode_get
    if _newclass:mode = property(_playerc.player_wifi_link_t_mode_get, _playerc.player_wifi_link_t_mode_set)
    __swig_setmethods__["freq"] = _playerc.player_wifi_link_t_freq_set
    __swig_getmethods__["freq"] = _playerc.player_wifi_link_t_freq_get
    if _newclass:freq = property(_playerc.player_wifi_link_t_freq_get, _playerc.player_wifi_link_t_freq_set)
    __swig_setmethods__["encrypt"] = _playerc.player_wifi_link_t_encrypt_set
    __swig_getmethods__["encrypt"] = _playerc.player_wifi_link_t_encrypt_get
    if _newclass:encrypt = property(_playerc.player_wifi_link_t_encrypt_get, _playerc.player_wifi_link_t_encrypt_set)
    __swig_setmethods__["qual"] = _playerc.player_wifi_link_t_qual_set
    __swig_getmethods__["qual"] = _playerc.player_wifi_link_t_qual_get
    if _newclass:qual = property(_playerc.player_wifi_link_t_qual_get, _playerc.player_wifi_link_t_qual_set)
    __swig_setmethods__["level"] = _playerc.player_wifi_link_t_level_set
    __swig_getmethods__["level"] = _playerc.player_wifi_link_t_level_get
    if _newclass:level = property(_playerc.player_wifi_link_t_level_get, _playerc.player_wifi_link_t_level_set)
    __swig_setmethods__["noise"] = _playerc.player_wifi_link_t_noise_set
    __swig_getmethods__["noise"] = _playerc.player_wifi_link_t_noise_get
    if _newclass:noise = property(_playerc.player_wifi_link_t_noise_get, _playerc.player_wifi_link_t_noise_set)
    def __init__(self, *args): 
        this = _playerc.new_player_wifi_link_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_wifi_link_t
    __del__ = lambda self : None;
player_wifi_link_t_swigregister = _playerc.player_wifi_link_t_swigregister
player_wifi_link_t_swigregister(player_wifi_link_t)

class player_wifi_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_wifi_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_wifi_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["links_count"] = _playerc.player_wifi_data_t_links_count_set
    __swig_getmethods__["links_count"] = _playerc.player_wifi_data_t_links_count_get
    if _newclass:links_count = property(_playerc.player_wifi_data_t_links_count_get, _playerc.player_wifi_data_t_links_count_set)
    __swig_setmethods__["links"] = _playerc.player_wifi_data_t_links_set
    __swig_getmethods__["links"] = _playerc.player_wifi_data_t_links_get
    if _newclass:links = property(_playerc.player_wifi_data_t_links_get, _playerc.player_wifi_data_t_links_set)
    __swig_setmethods__["throughput"] = _playerc.player_wifi_data_t_throughput_set
    __swig_getmethods__["throughput"] = _playerc.player_wifi_data_t_throughput_get
    if _newclass:throughput = property(_playerc.player_wifi_data_t_throughput_get, _playerc.player_wifi_data_t_throughput_set)
    __swig_setmethods__["bitrate"] = _playerc.player_wifi_data_t_bitrate_set
    __swig_getmethods__["bitrate"] = _playerc.player_wifi_data_t_bitrate_get
    if _newclass:bitrate = property(_playerc.player_wifi_data_t_bitrate_get, _playerc.player_wifi_data_t_bitrate_set)
    __swig_setmethods__["mode"] = _playerc.player_wifi_data_t_mode_set
    __swig_getmethods__["mode"] = _playerc.player_wifi_data_t_mode_get
    if _newclass:mode = property(_playerc.player_wifi_data_t_mode_get, _playerc.player_wifi_data_t_mode_set)
    __swig_setmethods__["qual_type"] = _playerc.player_wifi_data_t_qual_type_set
    __swig_getmethods__["qual_type"] = _playerc.player_wifi_data_t_qual_type_get
    if _newclass:qual_type = property(_playerc.player_wifi_data_t_qual_type_get, _playerc.player_wifi_data_t_qual_type_set)
    __swig_setmethods__["maxqual"] = _playerc.player_wifi_data_t_maxqual_set
    __swig_getmethods__["maxqual"] = _playerc.player_wifi_data_t_maxqual_get
    if _newclass:maxqual = property(_playerc.player_wifi_data_t_maxqual_get, _playerc.player_wifi_data_t_maxqual_set)
    __swig_setmethods__["maxlevel"] = _playerc.player_wifi_data_t_maxlevel_set
    __swig_getmethods__["maxlevel"] = _playerc.player_wifi_data_t_maxlevel_get
    if _newclass:maxlevel = property(_playerc.player_wifi_data_t_maxlevel_get, _playerc.player_wifi_data_t_maxlevel_set)
    __swig_setmethods__["maxnoise"] = _playerc.player_wifi_data_t_maxnoise_set
    __swig_getmethods__["maxnoise"] = _playerc.player_wifi_data_t_maxnoise_get
    if _newclass:maxnoise = property(_playerc.player_wifi_data_t_maxnoise_get, _playerc.player_wifi_data_t_maxnoise_set)
    __swig_setmethods__["ap"] = _playerc.player_wifi_data_t_ap_set
    __swig_getmethods__["ap"] = _playerc.player_wifi_data_t_ap_get
    if _newclass:ap = property(_playerc.player_wifi_data_t_ap_get, _playerc.player_wifi_data_t_ap_set)
    def __init__(self, *args): 
        this = _playerc.new_player_wifi_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_wifi_data_t
    __del__ = lambda self : None;
player_wifi_data_t_swigregister = _playerc.player_wifi_data_t_swigregister
player_wifi_data_t_swigregister(player_wifi_data_t)

class player_wifi_mac_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_wifi_mac_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_wifi_mac_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["mac_count"] = _playerc.player_wifi_mac_req_t_mac_count_set
    __swig_getmethods__["mac_count"] = _playerc.player_wifi_mac_req_t_mac_count_get
    if _newclass:mac_count = property(_playerc.player_wifi_mac_req_t_mac_count_get, _playerc.player_wifi_mac_req_t_mac_count_set)
    __swig_setmethods__["mac"] = _playerc.player_wifi_mac_req_t_mac_set
    __swig_getmethods__["mac"] = _playerc.player_wifi_mac_req_t_mac_get
    if _newclass:mac = property(_playerc.player_wifi_mac_req_t_mac_get, _playerc.player_wifi_mac_req_t_mac_set)
    def __init__(self, *args): 
        this = _playerc.new_player_wifi_mac_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_wifi_mac_req_t
    __del__ = lambda self : None;
player_wifi_mac_req_t_swigregister = _playerc.player_wifi_mac_req_t_swigregister
player_wifi_mac_req_t_swigregister(player_wifi_mac_req_t)

class player_wifi_iwspy_addr_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_wifi_iwspy_addr_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_wifi_iwspy_addr_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["address"] = _playerc.player_wifi_iwspy_addr_req_t_address_set
    __swig_getmethods__["address"] = _playerc.player_wifi_iwspy_addr_req_t_address_get
    if _newclass:address = property(_playerc.player_wifi_iwspy_addr_req_t_address_get, _playerc.player_wifi_iwspy_addr_req_t_address_set)
    def __init__(self, *args): 
        this = _playerc.new_player_wifi_iwspy_addr_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_wifi_iwspy_addr_req_t
    __del__ = lambda self : None;
player_wifi_iwspy_addr_req_t_swigregister = _playerc.player_wifi_iwspy_addr_req_t_swigregister
player_wifi_iwspy_addr_req_t_swigregister(player_wifi_iwspy_addr_req_t)

PLAYER_LOCALIZE_CODE = _playerc.PLAYER_LOCALIZE_CODE
PLAYER_LOCALIZE_STRING = _playerc.PLAYER_LOCALIZE_STRING
PLAYER_LOCALIZE_DATA_HYPOTHS = _playerc.PLAYER_LOCALIZE_DATA_HYPOTHS
PLAYER_LOCALIZE_REQ_SET_POSE = _playerc.PLAYER_LOCALIZE_REQ_SET_POSE
PLAYER_LOCALIZE_REQ_GET_PARTICLES = _playerc.PLAYER_LOCALIZE_REQ_GET_PARTICLES
class player_localize_hypoth_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_localize_hypoth_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_localize_hypoth_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["mean"] = _playerc.player_localize_hypoth_t_mean_set
    __swig_getmethods__["mean"] = _playerc.player_localize_hypoth_t_mean_get
    if _newclass:mean = property(_playerc.player_localize_hypoth_t_mean_get, _playerc.player_localize_hypoth_t_mean_set)
    __swig_setmethods__["cov"] = _playerc.player_localize_hypoth_t_cov_set
    __swig_getmethods__["cov"] = _playerc.player_localize_hypoth_t_cov_get
    if _newclass:cov = property(_playerc.player_localize_hypoth_t_cov_get, _playerc.player_localize_hypoth_t_cov_set)
    __swig_setmethods__["alpha"] = _playerc.player_localize_hypoth_t_alpha_set
    __swig_getmethods__["alpha"] = _playerc.player_localize_hypoth_t_alpha_get
    if _newclass:alpha = property(_playerc.player_localize_hypoth_t_alpha_get, _playerc.player_localize_hypoth_t_alpha_set)
    def __init__(self, *args): 
        this = _playerc.new_player_localize_hypoth_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_localize_hypoth_t
    __del__ = lambda self : None;
player_localize_hypoth_t_swigregister = _playerc.player_localize_hypoth_t_swigregister
player_localize_hypoth_t_swigregister(player_localize_hypoth_t)

class player_localize_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_localize_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_localize_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pending_count"] = _playerc.player_localize_data_t_pending_count_set
    __swig_getmethods__["pending_count"] = _playerc.player_localize_data_t_pending_count_get
    if _newclass:pending_count = property(_playerc.player_localize_data_t_pending_count_get, _playerc.player_localize_data_t_pending_count_set)
    __swig_setmethods__["pending_time"] = _playerc.player_localize_data_t_pending_time_set
    __swig_getmethods__["pending_time"] = _playerc.player_localize_data_t_pending_time_get
    if _newclass:pending_time = property(_playerc.player_localize_data_t_pending_time_get, _playerc.player_localize_data_t_pending_time_set)
    __swig_setmethods__["hypoths_count"] = _playerc.player_localize_data_t_hypoths_count_set
    __swig_getmethods__["hypoths_count"] = _playerc.player_localize_data_t_hypoths_count_get
    if _newclass:hypoths_count = property(_playerc.player_localize_data_t_hypoths_count_get, _playerc.player_localize_data_t_hypoths_count_set)
    __swig_setmethods__["hypoths"] = _playerc.player_localize_data_t_hypoths_set
    __swig_getmethods__["hypoths"] = _playerc.player_localize_data_t_hypoths_get
    if _newclass:hypoths = property(_playerc.player_localize_data_t_hypoths_get, _playerc.player_localize_data_t_hypoths_set)
    def __init__(self, *args): 
        this = _playerc.new_player_localize_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_localize_data_t
    __del__ = lambda self : None;
player_localize_data_t_swigregister = _playerc.player_localize_data_t_swigregister
player_localize_data_t_swigregister(player_localize_data_t)

class player_localize_set_pose_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_localize_set_pose_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_localize_set_pose_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["mean"] = _playerc.player_localize_set_pose_t_mean_set
    __swig_getmethods__["mean"] = _playerc.player_localize_set_pose_t_mean_get
    if _newclass:mean = property(_playerc.player_localize_set_pose_t_mean_get, _playerc.player_localize_set_pose_t_mean_set)
    __swig_setmethods__["cov"] = _playerc.player_localize_set_pose_t_cov_set
    __swig_getmethods__["cov"] = _playerc.player_localize_set_pose_t_cov_get
    if _newclass:cov = property(_playerc.player_localize_set_pose_t_cov_get, _playerc.player_localize_set_pose_t_cov_set)
    def __init__(self, *args): 
        this = _playerc.new_player_localize_set_pose_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_localize_set_pose_t
    __del__ = lambda self : None;
player_localize_set_pose_t_swigregister = _playerc.player_localize_set_pose_t_swigregister
player_localize_set_pose_t_swigregister(player_localize_set_pose_t)

class player_localize_particle_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_localize_particle_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_localize_particle_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_localize_particle_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_localize_particle_t_pose_get
    if _newclass:pose = property(_playerc.player_localize_particle_t_pose_get, _playerc.player_localize_particle_t_pose_set)
    __swig_setmethods__["alpha"] = _playerc.player_localize_particle_t_alpha_set
    __swig_getmethods__["alpha"] = _playerc.player_localize_particle_t_alpha_get
    if _newclass:alpha = property(_playerc.player_localize_particle_t_alpha_get, _playerc.player_localize_particle_t_alpha_set)
    def __init__(self, *args): 
        this = _playerc.new_player_localize_particle_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_localize_particle_t
    __del__ = lambda self : None;
player_localize_particle_t_swigregister = _playerc.player_localize_particle_t_swigregister
player_localize_particle_t_swigregister(player_localize_particle_t)

class player_localize_get_particles_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_localize_get_particles_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_localize_get_particles_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["mean"] = _playerc.player_localize_get_particles_t_mean_set
    __swig_getmethods__["mean"] = _playerc.player_localize_get_particles_t_mean_get
    if _newclass:mean = property(_playerc.player_localize_get_particles_t_mean_get, _playerc.player_localize_get_particles_t_mean_set)
    __swig_setmethods__["variance"] = _playerc.player_localize_get_particles_t_variance_set
    __swig_getmethods__["variance"] = _playerc.player_localize_get_particles_t_variance_get
    if _newclass:variance = property(_playerc.player_localize_get_particles_t_variance_get, _playerc.player_localize_get_particles_t_variance_set)
    __swig_setmethods__["particles_count"] = _playerc.player_localize_get_particles_t_particles_count_set
    __swig_getmethods__["particles_count"] = _playerc.player_localize_get_particles_t_particles_count_get
    if _newclass:particles_count = property(_playerc.player_localize_get_particles_t_particles_count_get, _playerc.player_localize_get_particles_t_particles_count_set)
    __swig_setmethods__["particles"] = _playerc.player_localize_get_particles_t_particles_set
    __swig_getmethods__["particles"] = _playerc.player_localize_get_particles_t_particles_get
    if _newclass:particles = property(_playerc.player_localize_get_particles_t_particles_get, _playerc.player_localize_get_particles_t_particles_set)
    def __init__(self, *args): 
        this = _playerc.new_player_localize_get_particles_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_localize_get_particles_t
    __del__ = lambda self : None;
player_localize_get_particles_t_swigregister = _playerc.player_localize_get_particles_t_swigregister
player_localize_get_particles_t_swigregister(player_localize_get_particles_t)

PLAYER_POSITION3D_CODE = _playerc.PLAYER_POSITION3D_CODE
PLAYER_POSITION3D_STRING = _playerc.PLAYER_POSITION3D_STRING
PLAYER_POSITION3D_DATA_STATE = _playerc.PLAYER_POSITION3D_DATA_STATE
PLAYER_POSITION3D_DATA_GEOMETRY = _playerc.PLAYER_POSITION3D_DATA_GEOMETRY
PLAYER_POSITION3D_CMD_SET_VEL = _playerc.PLAYER_POSITION3D_CMD_SET_VEL
PLAYER_POSITION3D_CMD_SET_POS = _playerc.PLAYER_POSITION3D_CMD_SET_POS
PLAYER_POSITION3D_REQ_GET_GEOM = _playerc.PLAYER_POSITION3D_REQ_GET_GEOM
PLAYER_POSITION3D_REQ_MOTOR_POWER = _playerc.PLAYER_POSITION3D_REQ_MOTOR_POWER
PLAYER_POSITION3D_REQ_VELOCITY_MODE = _playerc.PLAYER_POSITION3D_REQ_VELOCITY_MODE
PLAYER_POSITION3D_REQ_POSITION_MODE = _playerc.PLAYER_POSITION3D_REQ_POSITION_MODE
PLAYER_POSITION3D_REQ_RESET_ODOM = _playerc.PLAYER_POSITION3D_REQ_RESET_ODOM
PLAYER_POSITION3D_REQ_SET_ODOM = _playerc.PLAYER_POSITION3D_REQ_SET_ODOM
PLAYER_POSITION3D_REQ_SPEED_PID = _playerc.PLAYER_POSITION3D_REQ_SPEED_PID
PLAYER_POSITION3D_REQ_POSITION_PID = _playerc.PLAYER_POSITION3D_REQ_POSITION_PID
PLAYER_POSITION3D_REQ_SPEED_PROF = _playerc.PLAYER_POSITION3D_REQ_SPEED_PROF
class player_position3d_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pos"] = _playerc.player_position3d_data_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_position3d_data_t_pos_get
    if _newclass:pos = property(_playerc.player_position3d_data_t_pos_get, _playerc.player_position3d_data_t_pos_set)
    __swig_setmethods__["vel"] = _playerc.player_position3d_data_t_vel_set
    __swig_getmethods__["vel"] = _playerc.player_position3d_data_t_vel_get
    if _newclass:vel = property(_playerc.player_position3d_data_t_vel_get, _playerc.player_position3d_data_t_vel_set)
    __swig_setmethods__["stall"] = _playerc.player_position3d_data_t_stall_set
    __swig_getmethods__["stall"] = _playerc.player_position3d_data_t_stall_get
    if _newclass:stall = property(_playerc.player_position3d_data_t_stall_get, _playerc.player_position3d_data_t_stall_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_data_t
    __del__ = lambda self : None;
player_position3d_data_t_swigregister = _playerc.player_position3d_data_t_swigregister
player_position3d_data_t_swigregister(player_position3d_data_t)

class player_position3d_cmd_pos_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_cmd_pos_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_cmd_pos_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pos"] = _playerc.player_position3d_cmd_pos_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_position3d_cmd_pos_t_pos_get
    if _newclass:pos = property(_playerc.player_position3d_cmd_pos_t_pos_get, _playerc.player_position3d_cmd_pos_t_pos_set)
    __swig_setmethods__["vel"] = _playerc.player_position3d_cmd_pos_t_vel_set
    __swig_getmethods__["vel"] = _playerc.player_position3d_cmd_pos_t_vel_get
    if _newclass:vel = property(_playerc.player_position3d_cmd_pos_t_vel_get, _playerc.player_position3d_cmd_pos_t_vel_set)
    __swig_setmethods__["state"] = _playerc.player_position3d_cmd_pos_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position3d_cmd_pos_t_state_get
    if _newclass:state = property(_playerc.player_position3d_cmd_pos_t_state_get, _playerc.player_position3d_cmd_pos_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_cmd_pos_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_cmd_pos_t
    __del__ = lambda self : None;
player_position3d_cmd_pos_t_swigregister = _playerc.player_position3d_cmd_pos_t_swigregister
player_position3d_cmd_pos_t_swigregister(player_position3d_cmd_pos_t)

class player_position3d_cmd_vel_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_cmd_vel_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_cmd_vel_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["vel"] = _playerc.player_position3d_cmd_vel_t_vel_set
    __swig_getmethods__["vel"] = _playerc.player_position3d_cmd_vel_t_vel_get
    if _newclass:vel = property(_playerc.player_position3d_cmd_vel_t_vel_get, _playerc.player_position3d_cmd_vel_t_vel_set)
    __swig_setmethods__["state"] = _playerc.player_position3d_cmd_vel_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position3d_cmd_vel_t_state_get
    if _newclass:state = property(_playerc.player_position3d_cmd_vel_t_state_get, _playerc.player_position3d_cmd_vel_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_cmd_vel_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_cmd_vel_t
    __del__ = lambda self : None;
player_position3d_cmd_vel_t_swigregister = _playerc.player_position3d_cmd_vel_t_swigregister
player_position3d_cmd_vel_t_swigregister(player_position3d_cmd_vel_t)

class player_position3d_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_position3d_geom_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_position3d_geom_t_pose_get
    if _newclass:pose = property(_playerc.player_position3d_geom_t_pose_get, _playerc.player_position3d_geom_t_pose_set)
    __swig_setmethods__["size"] = _playerc.player_position3d_geom_t_size_set
    __swig_getmethods__["size"] = _playerc.player_position3d_geom_t_size_get
    if _newclass:size = property(_playerc.player_position3d_geom_t_size_get, _playerc.player_position3d_geom_t_size_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_geom_t
    __del__ = lambda self : None;
player_position3d_geom_t_swigregister = _playerc.player_position3d_geom_t_swigregister
player_position3d_geom_t_swigregister(player_position3d_geom_t)

class player_position3d_power_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_power_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_power_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_position3d_power_config_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position3d_power_config_t_state_get
    if _newclass:state = property(_playerc.player_position3d_power_config_t_state_get, _playerc.player_position3d_power_config_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_power_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_power_config_t
    __del__ = lambda self : None;
player_position3d_power_config_t_swigregister = _playerc.player_position3d_power_config_t_swigregister
player_position3d_power_config_t_swigregister(player_position3d_power_config_t)

class player_position3d_position_mode_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_position_mode_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_position_mode_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_position3d_position_mode_req_t_value_set
    __swig_getmethods__["value"] = _playerc.player_position3d_position_mode_req_t_value_get
    if _newclass:value = property(_playerc.player_position3d_position_mode_req_t_value_get, _playerc.player_position3d_position_mode_req_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_position_mode_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_position_mode_req_t
    __del__ = lambda self : None;
player_position3d_position_mode_req_t_swigregister = _playerc.player_position3d_position_mode_req_t_swigregister
player_position3d_position_mode_req_t_swigregister(player_position3d_position_mode_req_t)

class player_position3d_velocity_mode_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_velocity_mode_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_velocity_mode_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_position3d_velocity_mode_config_t_value_set
    __swig_getmethods__["value"] = _playerc.player_position3d_velocity_mode_config_t_value_get
    if _newclass:value = property(_playerc.player_position3d_velocity_mode_config_t_value_get, _playerc.player_position3d_velocity_mode_config_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_velocity_mode_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_velocity_mode_config_t
    __del__ = lambda self : None;
player_position3d_velocity_mode_config_t_swigregister = _playerc.player_position3d_velocity_mode_config_t_swigregister
player_position3d_velocity_mode_config_t_swigregister(player_position3d_velocity_mode_config_t)

class player_position3d_set_odom_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_set_odom_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_set_odom_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pos"] = _playerc.player_position3d_set_odom_req_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_position3d_set_odom_req_t_pos_get
    if _newclass:pos = property(_playerc.player_position3d_set_odom_req_t_pos_get, _playerc.player_position3d_set_odom_req_t_pos_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_set_odom_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_set_odom_req_t
    __del__ = lambda self : None;
player_position3d_set_odom_req_t_swigregister = _playerc.player_position3d_set_odom_req_t_swigregister
player_position3d_set_odom_req_t_swigregister(player_position3d_set_odom_req_t)

class player_position3d_speed_pid_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_speed_pid_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_speed_pid_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["kp"] = _playerc.player_position3d_speed_pid_req_t_kp_set
    __swig_getmethods__["kp"] = _playerc.player_position3d_speed_pid_req_t_kp_get
    if _newclass:kp = property(_playerc.player_position3d_speed_pid_req_t_kp_get, _playerc.player_position3d_speed_pid_req_t_kp_set)
    __swig_setmethods__["ki"] = _playerc.player_position3d_speed_pid_req_t_ki_set
    __swig_getmethods__["ki"] = _playerc.player_position3d_speed_pid_req_t_ki_get
    if _newclass:ki = property(_playerc.player_position3d_speed_pid_req_t_ki_get, _playerc.player_position3d_speed_pid_req_t_ki_set)
    __swig_setmethods__["kd"] = _playerc.player_position3d_speed_pid_req_t_kd_set
    __swig_getmethods__["kd"] = _playerc.player_position3d_speed_pid_req_t_kd_get
    if _newclass:kd = property(_playerc.player_position3d_speed_pid_req_t_kd_get, _playerc.player_position3d_speed_pid_req_t_kd_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_speed_pid_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_speed_pid_req_t
    __del__ = lambda self : None;
player_position3d_speed_pid_req_t_swigregister = _playerc.player_position3d_speed_pid_req_t_swigregister
player_position3d_speed_pid_req_t_swigregister(player_position3d_speed_pid_req_t)

class player_position3d_position_pid_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_position_pid_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_position_pid_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["kp"] = _playerc.player_position3d_position_pid_req_t_kp_set
    __swig_getmethods__["kp"] = _playerc.player_position3d_position_pid_req_t_kp_get
    if _newclass:kp = property(_playerc.player_position3d_position_pid_req_t_kp_get, _playerc.player_position3d_position_pid_req_t_kp_set)
    __swig_setmethods__["ki"] = _playerc.player_position3d_position_pid_req_t_ki_set
    __swig_getmethods__["ki"] = _playerc.player_position3d_position_pid_req_t_ki_get
    if _newclass:ki = property(_playerc.player_position3d_position_pid_req_t_ki_get, _playerc.player_position3d_position_pid_req_t_ki_set)
    __swig_setmethods__["kd"] = _playerc.player_position3d_position_pid_req_t_kd_set
    __swig_getmethods__["kd"] = _playerc.player_position3d_position_pid_req_t_kd_get
    if _newclass:kd = property(_playerc.player_position3d_position_pid_req_t_kd_get, _playerc.player_position3d_position_pid_req_t_kd_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_position_pid_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_position_pid_req_t
    __del__ = lambda self : None;
player_position3d_position_pid_req_t_swigregister = _playerc.player_position3d_position_pid_req_t_swigregister
player_position3d_position_pid_req_t_swigregister(player_position3d_position_pid_req_t)

class player_position3d_speed_prof_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position3d_speed_prof_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position3d_speed_prof_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["speed"] = _playerc.player_position3d_speed_prof_req_t_speed_set
    __swig_getmethods__["speed"] = _playerc.player_position3d_speed_prof_req_t_speed_get
    if _newclass:speed = property(_playerc.player_position3d_speed_prof_req_t_speed_get, _playerc.player_position3d_speed_prof_req_t_speed_set)
    __swig_setmethods__["acc"] = _playerc.player_position3d_speed_prof_req_t_acc_set
    __swig_getmethods__["acc"] = _playerc.player_position3d_speed_prof_req_t_acc_get
    if _newclass:acc = property(_playerc.player_position3d_speed_prof_req_t_acc_get, _playerc.player_position3d_speed_prof_req_t_acc_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position3d_speed_prof_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position3d_speed_prof_req_t
    __del__ = lambda self : None;
player_position3d_speed_prof_req_t_swigregister = _playerc.player_position3d_speed_prof_req_t_swigregister
player_position3d_speed_prof_req_t_swigregister(player_position3d_speed_prof_req_t)

PLAYER_SIMULATION_CODE = _playerc.PLAYER_SIMULATION_CODE
PLAYER_SIMULATION_STRING = _playerc.PLAYER_SIMULATION_STRING
PLAYER_SIMULATION_REQ_GET_POSE2D = _playerc.PLAYER_SIMULATION_REQ_GET_POSE2D
PLAYER_SIMULATION_REQ_SET_POSE2D = _playerc.PLAYER_SIMULATION_REQ_SET_POSE2D
PLAYER_SIMULATION_REQ_GET_POSE3D = _playerc.PLAYER_SIMULATION_REQ_GET_POSE3D
PLAYER_SIMULATION_REQ_SET_POSE3D = _playerc.PLAYER_SIMULATION_REQ_SET_POSE3D
PLAYER_SIMULATION_REQ_GET_PROPERTY = _playerc.PLAYER_SIMULATION_REQ_GET_PROPERTY
PLAYER_SIMULATION_REQ_SET_PROPERTY = _playerc.PLAYER_SIMULATION_REQ_SET_PROPERTY
PLAYER_SIMULATION_CMD_PAUSE = _playerc.PLAYER_SIMULATION_CMD_PAUSE
PLAYER_SIMULATION_CMD_RESET = _playerc.PLAYER_SIMULATION_CMD_RESET
PLAYER_SIMULATION_CMD_SAVE = _playerc.PLAYER_SIMULATION_CMD_SAVE
class player_simulation_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_simulation_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_simulation_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["data"] = _playerc.player_simulation_data_t_data_set
    __swig_getmethods__["data"] = _playerc.player_simulation_data_t_data_get
    if _newclass:data = property(_playerc.player_simulation_data_t_data_get, _playerc.player_simulation_data_t_data_set)
    def __init__(self, *args): 
        this = _playerc.new_player_simulation_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_simulation_data_t
    __del__ = lambda self : None;
player_simulation_data_t_swigregister = _playerc.player_simulation_data_t_swigregister
player_simulation_data_t_swigregister(player_simulation_data_t)

class player_simulation_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_simulation_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_simulation_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["cmd"] = _playerc.player_simulation_cmd_t_cmd_set
    __swig_getmethods__["cmd"] = _playerc.player_simulation_cmd_t_cmd_get
    if _newclass:cmd = property(_playerc.player_simulation_cmd_t_cmd_get, _playerc.player_simulation_cmd_t_cmd_set)
    def __init__(self, *args): 
        this = _playerc.new_player_simulation_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_simulation_cmd_t
    __del__ = lambda self : None;
player_simulation_cmd_t_swigregister = _playerc.player_simulation_cmd_t_swigregister
player_simulation_cmd_t_swigregister(player_simulation_cmd_t)

class player_simulation_pose2d_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_simulation_pose2d_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_simulation_pose2d_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["name_count"] = _playerc.player_simulation_pose2d_req_t_name_count_set
    __swig_getmethods__["name_count"] = _playerc.player_simulation_pose2d_req_t_name_count_get
    if _newclass:name_count = property(_playerc.player_simulation_pose2d_req_t_name_count_get, _playerc.player_simulation_pose2d_req_t_name_count_set)
    __swig_setmethods__["name"] = _playerc.player_simulation_pose2d_req_t_name_set
    __swig_getmethods__["name"] = _playerc.player_simulation_pose2d_req_t_name_get
    if _newclass:name = property(_playerc.player_simulation_pose2d_req_t_name_get, _playerc.player_simulation_pose2d_req_t_name_set)
    __swig_setmethods__["pose"] = _playerc.player_simulation_pose2d_req_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_simulation_pose2d_req_t_pose_get
    if _newclass:pose = property(_playerc.player_simulation_pose2d_req_t_pose_get, _playerc.player_simulation_pose2d_req_t_pose_set)
    def __init__(self, *args): 
        this = _playerc.new_player_simulation_pose2d_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_simulation_pose2d_req_t
    __del__ = lambda self : None;
player_simulation_pose2d_req_t_swigregister = _playerc.player_simulation_pose2d_req_t_swigregister
player_simulation_pose2d_req_t_swigregister(player_simulation_pose2d_req_t)

class player_simulation_pose3d_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_simulation_pose3d_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_simulation_pose3d_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["name_count"] = _playerc.player_simulation_pose3d_req_t_name_count_set
    __swig_getmethods__["name_count"] = _playerc.player_simulation_pose3d_req_t_name_count_get
    if _newclass:name_count = property(_playerc.player_simulation_pose3d_req_t_name_count_get, _playerc.player_simulation_pose3d_req_t_name_count_set)
    __swig_setmethods__["name"] = _playerc.player_simulation_pose3d_req_t_name_set
    __swig_getmethods__["name"] = _playerc.player_simulation_pose3d_req_t_name_get
    if _newclass:name = property(_playerc.player_simulation_pose3d_req_t_name_get, _playerc.player_simulation_pose3d_req_t_name_set)
    __swig_setmethods__["pose"] = _playerc.player_simulation_pose3d_req_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_simulation_pose3d_req_t_pose_get
    if _newclass:pose = property(_playerc.player_simulation_pose3d_req_t_pose_get, _playerc.player_simulation_pose3d_req_t_pose_set)
    __swig_setmethods__["simtime"] = _playerc.player_simulation_pose3d_req_t_simtime_set
    __swig_getmethods__["simtime"] = _playerc.player_simulation_pose3d_req_t_simtime_get
    if _newclass:simtime = property(_playerc.player_simulation_pose3d_req_t_simtime_get, _playerc.player_simulation_pose3d_req_t_simtime_set)
    def __init__(self, *args): 
        this = _playerc.new_player_simulation_pose3d_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_simulation_pose3d_req_t
    __del__ = lambda self : None;
player_simulation_pose3d_req_t_swigregister = _playerc.player_simulation_pose3d_req_t_swigregister
player_simulation_pose3d_req_t_swigregister(player_simulation_pose3d_req_t)

class player_simulation_property_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_simulation_property_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_simulation_property_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["name_count"] = _playerc.player_simulation_property_req_t_name_count_set
    __swig_getmethods__["name_count"] = _playerc.player_simulation_property_req_t_name_count_get
    if _newclass:name_count = property(_playerc.player_simulation_property_req_t_name_count_get, _playerc.player_simulation_property_req_t_name_count_set)
    __swig_setmethods__["name"] = _playerc.player_simulation_property_req_t_name_set
    __swig_getmethods__["name"] = _playerc.player_simulation_property_req_t_name_get
    if _newclass:name = property(_playerc.player_simulation_property_req_t_name_get, _playerc.player_simulation_property_req_t_name_set)
    __swig_setmethods__["prop_count"] = _playerc.player_simulation_property_req_t_prop_count_set
    __swig_getmethods__["prop_count"] = _playerc.player_simulation_property_req_t_prop_count_get
    if _newclass:prop_count = property(_playerc.player_simulation_property_req_t_prop_count_get, _playerc.player_simulation_property_req_t_prop_count_set)
    __swig_setmethods__["prop"] = _playerc.player_simulation_property_req_t_prop_set
    __swig_getmethods__["prop"] = _playerc.player_simulation_property_req_t_prop_get
    if _newclass:prop = property(_playerc.player_simulation_property_req_t_prop_get, _playerc.player_simulation_property_req_t_prop_set)
    __swig_setmethods__["index"] = _playerc.player_simulation_property_req_t_index_set
    __swig_getmethods__["index"] = _playerc.player_simulation_property_req_t_index_get
    if _newclass:index = property(_playerc.player_simulation_property_req_t_index_get, _playerc.player_simulation_property_req_t_index_set)
    __swig_setmethods__["value_count"] = _playerc.player_simulation_property_req_t_value_count_set
    __swig_getmethods__["value_count"] = _playerc.player_simulation_property_req_t_value_count_get
    if _newclass:value_count = property(_playerc.player_simulation_property_req_t_value_count_get, _playerc.player_simulation_property_req_t_value_count_set)
    __swig_setmethods__["value"] = _playerc.player_simulation_property_req_t_value_set
    __swig_getmethods__["value"] = _playerc.player_simulation_property_req_t_value_get
    if _newclass:value = property(_playerc.player_simulation_property_req_t_value_get, _playerc.player_simulation_property_req_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_simulation_property_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_simulation_property_req_t
    __del__ = lambda self : None;
player_simulation_property_req_t_swigregister = _playerc.player_simulation_property_req_t_swigregister
player_simulation_property_req_t_swigregister(player_simulation_property_req_t)

PLAYER_BLINKENLIGHT_CODE = _playerc.PLAYER_BLINKENLIGHT_CODE
PLAYER_BLINKENLIGHT_STRING = _playerc.PLAYER_BLINKENLIGHT_STRING
PLAYER_BLINKENLIGHT_DATA_STATE = _playerc.PLAYER_BLINKENLIGHT_DATA_STATE
PLAYER_BLINKENLIGHT_CMD_STATE = _playerc.PLAYER_BLINKENLIGHT_CMD_STATE
PLAYER_BLINKENLIGHT_CMD_POWER = _playerc.PLAYER_BLINKENLIGHT_CMD_POWER
PLAYER_BLINKENLIGHT_CMD_COLOR = _playerc.PLAYER_BLINKENLIGHT_CMD_COLOR
PLAYER_BLINKENLIGHT_CMD_FLASH = _playerc.PLAYER_BLINKENLIGHT_CMD_FLASH
class player_blinkenlight_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_blinkenlight_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_blinkenlight_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["enable"] = _playerc.player_blinkenlight_data_t_enable_set
    __swig_getmethods__["enable"] = _playerc.player_blinkenlight_data_t_enable_get
    if _newclass:enable = property(_playerc.player_blinkenlight_data_t_enable_get, _playerc.player_blinkenlight_data_t_enable_set)
    __swig_setmethods__["period"] = _playerc.player_blinkenlight_data_t_period_set
    __swig_getmethods__["period"] = _playerc.player_blinkenlight_data_t_period_get
    if _newclass:period = property(_playerc.player_blinkenlight_data_t_period_get, _playerc.player_blinkenlight_data_t_period_set)
    __swig_setmethods__["dutycycle"] = _playerc.player_blinkenlight_data_t_dutycycle_set
    __swig_getmethods__["dutycycle"] = _playerc.player_blinkenlight_data_t_dutycycle_get
    if _newclass:dutycycle = property(_playerc.player_blinkenlight_data_t_dutycycle_get, _playerc.player_blinkenlight_data_t_dutycycle_set)
    __swig_setmethods__["color"] = _playerc.player_blinkenlight_data_t_color_set
    __swig_getmethods__["color"] = _playerc.player_blinkenlight_data_t_color_get
    if _newclass:color = property(_playerc.player_blinkenlight_data_t_color_get, _playerc.player_blinkenlight_data_t_color_set)
    def __init__(self, *args): 
        this = _playerc.new_player_blinkenlight_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_blinkenlight_data_t
    __del__ = lambda self : None;
player_blinkenlight_data_t_swigregister = _playerc.player_blinkenlight_data_t_swigregister
player_blinkenlight_data_t_swigregister(player_blinkenlight_data_t)

class player_blinkenlight_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_blinkenlight_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_blinkenlight_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["id"] = _playerc.player_blinkenlight_cmd_t_id_set
    __swig_getmethods__["id"] = _playerc.player_blinkenlight_cmd_t_id_get
    if _newclass:id = property(_playerc.player_blinkenlight_cmd_t_id_get, _playerc.player_blinkenlight_cmd_t_id_set)
    __swig_setmethods__["enable"] = _playerc.player_blinkenlight_cmd_t_enable_set
    __swig_getmethods__["enable"] = _playerc.player_blinkenlight_cmd_t_enable_get
    if _newclass:enable = property(_playerc.player_blinkenlight_cmd_t_enable_get, _playerc.player_blinkenlight_cmd_t_enable_set)
    __swig_setmethods__["period"] = _playerc.player_blinkenlight_cmd_t_period_set
    __swig_getmethods__["period"] = _playerc.player_blinkenlight_cmd_t_period_get
    if _newclass:period = property(_playerc.player_blinkenlight_cmd_t_period_get, _playerc.player_blinkenlight_cmd_t_period_set)
    __swig_setmethods__["dutycycle"] = _playerc.player_blinkenlight_cmd_t_dutycycle_set
    __swig_getmethods__["dutycycle"] = _playerc.player_blinkenlight_cmd_t_dutycycle_get
    if _newclass:dutycycle = property(_playerc.player_blinkenlight_cmd_t_dutycycle_get, _playerc.player_blinkenlight_cmd_t_dutycycle_set)
    __swig_setmethods__["color"] = _playerc.player_blinkenlight_cmd_t_color_set
    __swig_getmethods__["color"] = _playerc.player_blinkenlight_cmd_t_color_get
    if _newclass:color = property(_playerc.player_blinkenlight_cmd_t_color_get, _playerc.player_blinkenlight_cmd_t_color_set)
    def __init__(self, *args): 
        this = _playerc.new_player_blinkenlight_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_blinkenlight_cmd_t
    __del__ = lambda self : None;
player_blinkenlight_cmd_t_swigregister = _playerc.player_blinkenlight_cmd_t_swigregister
player_blinkenlight_cmd_t_swigregister(player_blinkenlight_cmd_t)

class player_blinkenlight_cmd_power_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_blinkenlight_cmd_power_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_blinkenlight_cmd_power_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["id"] = _playerc.player_blinkenlight_cmd_power_t_id_set
    __swig_getmethods__["id"] = _playerc.player_blinkenlight_cmd_power_t_id_get
    if _newclass:id = property(_playerc.player_blinkenlight_cmd_power_t_id_get, _playerc.player_blinkenlight_cmd_power_t_id_set)
    __swig_setmethods__["enable"] = _playerc.player_blinkenlight_cmd_power_t_enable_set
    __swig_getmethods__["enable"] = _playerc.player_blinkenlight_cmd_power_t_enable_get
    if _newclass:enable = property(_playerc.player_blinkenlight_cmd_power_t_enable_get, _playerc.player_blinkenlight_cmd_power_t_enable_set)
    def __init__(self, *args): 
        this = _playerc.new_player_blinkenlight_cmd_power_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_blinkenlight_cmd_power_t
    __del__ = lambda self : None;
player_blinkenlight_cmd_power_t_swigregister = _playerc.player_blinkenlight_cmd_power_t_swigregister
player_blinkenlight_cmd_power_t_swigregister(player_blinkenlight_cmd_power_t)

class player_blinkenlight_cmd_color_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_blinkenlight_cmd_color_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_blinkenlight_cmd_color_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["id"] = _playerc.player_blinkenlight_cmd_color_t_id_set
    __swig_getmethods__["id"] = _playerc.player_blinkenlight_cmd_color_t_id_get
    if _newclass:id = property(_playerc.player_blinkenlight_cmd_color_t_id_get, _playerc.player_blinkenlight_cmd_color_t_id_set)
    __swig_setmethods__["color"] = _playerc.player_blinkenlight_cmd_color_t_color_set
    __swig_getmethods__["color"] = _playerc.player_blinkenlight_cmd_color_t_color_get
    if _newclass:color = property(_playerc.player_blinkenlight_cmd_color_t_color_get, _playerc.player_blinkenlight_cmd_color_t_color_set)
    def __init__(self, *args): 
        this = _playerc.new_player_blinkenlight_cmd_color_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_blinkenlight_cmd_color_t
    __del__ = lambda self : None;
player_blinkenlight_cmd_color_t_swigregister = _playerc.player_blinkenlight_cmd_color_t_swigregister
player_blinkenlight_cmd_color_t_swigregister(player_blinkenlight_cmd_color_t)

class player_blinkenlight_cmd_flash_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_blinkenlight_cmd_flash_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_blinkenlight_cmd_flash_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["id"] = _playerc.player_blinkenlight_cmd_flash_t_id_set
    __swig_getmethods__["id"] = _playerc.player_blinkenlight_cmd_flash_t_id_get
    if _newclass:id = property(_playerc.player_blinkenlight_cmd_flash_t_id_get, _playerc.player_blinkenlight_cmd_flash_t_id_set)
    __swig_setmethods__["period"] = _playerc.player_blinkenlight_cmd_flash_t_period_set
    __swig_getmethods__["period"] = _playerc.player_blinkenlight_cmd_flash_t_period_get
    if _newclass:period = property(_playerc.player_blinkenlight_cmd_flash_t_period_get, _playerc.player_blinkenlight_cmd_flash_t_period_set)
    __swig_setmethods__["dutycycle"] = _playerc.player_blinkenlight_cmd_flash_t_dutycycle_set
    __swig_getmethods__["dutycycle"] = _playerc.player_blinkenlight_cmd_flash_t_dutycycle_get
    if _newclass:dutycycle = property(_playerc.player_blinkenlight_cmd_flash_t_dutycycle_get, _playerc.player_blinkenlight_cmd_flash_t_dutycycle_set)
    def __init__(self, *args): 
        this = _playerc.new_player_blinkenlight_cmd_flash_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_blinkenlight_cmd_flash_t
    __del__ = lambda self : None;
player_blinkenlight_cmd_flash_t_swigregister = _playerc.player_blinkenlight_cmd_flash_t_swigregister
player_blinkenlight_cmd_flash_t_swigregister(player_blinkenlight_cmd_flash_t)

PLAYER_CAMERA_CODE = _playerc.PLAYER_CAMERA_CODE
PLAYER_CAMERA_STRING = _playerc.PLAYER_CAMERA_STRING
PLAYER_CAMERA_DATA_STATE = _playerc.PLAYER_CAMERA_DATA_STATE
PLAYER_CAMERA_FORMAT_MONO8 = _playerc.PLAYER_CAMERA_FORMAT_MONO8
PLAYER_CAMERA_FORMAT_MONO16 = _playerc.PLAYER_CAMERA_FORMAT_MONO16
PLAYER_CAMERA_FORMAT_RGB565 = _playerc.PLAYER_CAMERA_FORMAT_RGB565
PLAYER_CAMERA_FORMAT_RGB888 = _playerc.PLAYER_CAMERA_FORMAT_RGB888
PLAYER_CAMERA_COMPRESS_RAW = _playerc.PLAYER_CAMERA_COMPRESS_RAW
PLAYER_CAMERA_COMPRESS_JPEG = _playerc.PLAYER_CAMERA_COMPRESS_JPEG
class player_camera_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_camera_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_camera_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["width"] = _playerc.player_camera_data_t_width_set
    __swig_getmethods__["width"] = _playerc.player_camera_data_t_width_get
    if _newclass:width = property(_playerc.player_camera_data_t_width_get, _playerc.player_camera_data_t_width_set)
    __swig_setmethods__["height"] = _playerc.player_camera_data_t_height_set
    __swig_getmethods__["height"] = _playerc.player_camera_data_t_height_get
    if _newclass:height = property(_playerc.player_camera_data_t_height_get, _playerc.player_camera_data_t_height_set)
    __swig_setmethods__["bpp"] = _playerc.player_camera_data_t_bpp_set
    __swig_getmethods__["bpp"] = _playerc.player_camera_data_t_bpp_get
    if _newclass:bpp = property(_playerc.player_camera_data_t_bpp_get, _playerc.player_camera_data_t_bpp_set)
    __swig_setmethods__["format"] = _playerc.player_camera_data_t_format_set
    __swig_getmethods__["format"] = _playerc.player_camera_data_t_format_get
    if _newclass:format = property(_playerc.player_camera_data_t_format_get, _playerc.player_camera_data_t_format_set)
    __swig_setmethods__["fdiv"] = _playerc.player_camera_data_t_fdiv_set
    __swig_getmethods__["fdiv"] = _playerc.player_camera_data_t_fdiv_get
    if _newclass:fdiv = property(_playerc.player_camera_data_t_fdiv_get, _playerc.player_camera_data_t_fdiv_set)
    __swig_setmethods__["compression"] = _playerc.player_camera_data_t_compression_set
    __swig_getmethods__["compression"] = _playerc.player_camera_data_t_compression_get
    if _newclass:compression = property(_playerc.player_camera_data_t_compression_get, _playerc.player_camera_data_t_compression_set)
    __swig_setmethods__["image_count"] = _playerc.player_camera_data_t_image_count_set
    __swig_getmethods__["image_count"] = _playerc.player_camera_data_t_image_count_get
    if _newclass:image_count = property(_playerc.player_camera_data_t_image_count_get, _playerc.player_camera_data_t_image_count_set)
    __swig_setmethods__["image"] = _playerc.player_camera_data_t_image_set
    __swig_getmethods__["image"] = _playerc.player_camera_data_t_image_get
    if _newclass:image = property(_playerc.player_camera_data_t_image_get, _playerc.player_camera_data_t_image_set)
    def __init__(self, *args): 
        this = _playerc.new_player_camera_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_camera_data_t
    __del__ = lambda self : None;
player_camera_data_t_swigregister = _playerc.player_camera_data_t_swigregister
player_camera_data_t_swigregister(player_camera_data_t)

PLAYER_MAP_CODE = _playerc.PLAYER_MAP_CODE
PLAYER_MAP_STRING = _playerc.PLAYER_MAP_STRING
PLAYER_MAP_DATA_INFO = _playerc.PLAYER_MAP_DATA_INFO
PLAYER_MAP_REQ_GET_INFO = _playerc.PLAYER_MAP_REQ_GET_INFO
PLAYER_MAP_REQ_GET_DATA = _playerc.PLAYER_MAP_REQ_GET_DATA
PLAYER_MAP_REQ_GET_VECTOR = _playerc.PLAYER_MAP_REQ_GET_VECTOR
class player_map_info_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_map_info_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_map_info_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["scale"] = _playerc.player_map_info_t_scale_set
    __swig_getmethods__["scale"] = _playerc.player_map_info_t_scale_get
    if _newclass:scale = property(_playerc.player_map_info_t_scale_get, _playerc.player_map_info_t_scale_set)
    __swig_setmethods__["width"] = _playerc.player_map_info_t_width_set
    __swig_getmethods__["width"] = _playerc.player_map_info_t_width_get
    if _newclass:width = property(_playerc.player_map_info_t_width_get, _playerc.player_map_info_t_width_set)
    __swig_setmethods__["height"] = _playerc.player_map_info_t_height_set
    __swig_getmethods__["height"] = _playerc.player_map_info_t_height_get
    if _newclass:height = property(_playerc.player_map_info_t_height_get, _playerc.player_map_info_t_height_set)
    __swig_setmethods__["origin"] = _playerc.player_map_info_t_origin_set
    __swig_getmethods__["origin"] = _playerc.player_map_info_t_origin_get
    if _newclass:origin = property(_playerc.player_map_info_t_origin_get, _playerc.player_map_info_t_origin_set)
    def __init__(self, *args): 
        this = _playerc.new_player_map_info_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_map_info_t
    __del__ = lambda self : None;
player_map_info_t_swigregister = _playerc.player_map_info_t_swigregister
player_map_info_t_swigregister(player_map_info_t)

class player_map_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_map_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_map_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["col"] = _playerc.player_map_data_t_col_set
    __swig_getmethods__["col"] = _playerc.player_map_data_t_col_get
    if _newclass:col = property(_playerc.player_map_data_t_col_get, _playerc.player_map_data_t_col_set)
    __swig_setmethods__["row"] = _playerc.player_map_data_t_row_set
    __swig_getmethods__["row"] = _playerc.player_map_data_t_row_get
    if _newclass:row = property(_playerc.player_map_data_t_row_get, _playerc.player_map_data_t_row_set)
    __swig_setmethods__["width"] = _playerc.player_map_data_t_width_set
    __swig_getmethods__["width"] = _playerc.player_map_data_t_width_get
    if _newclass:width = property(_playerc.player_map_data_t_width_get, _playerc.player_map_data_t_width_set)
    __swig_setmethods__["height"] = _playerc.player_map_data_t_height_set
    __swig_getmethods__["height"] = _playerc.player_map_data_t_height_get
    if _newclass:height = property(_playerc.player_map_data_t_height_get, _playerc.player_map_data_t_height_set)
    __swig_setmethods__["data_count"] = _playerc.player_map_data_t_data_count_set
    __swig_getmethods__["data_count"] = _playerc.player_map_data_t_data_count_get
    if _newclass:data_count = property(_playerc.player_map_data_t_data_count_get, _playerc.player_map_data_t_data_count_set)
    __swig_setmethods__["data"] = _playerc.player_map_data_t_data_set
    __swig_getmethods__["data"] = _playerc.player_map_data_t_data_get
    if _newclass:data = property(_playerc.player_map_data_t_data_get, _playerc.player_map_data_t_data_set)
    def __init__(self, *args): 
        this = _playerc.new_player_map_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_map_data_t
    __del__ = lambda self : None;
player_map_data_t_swigregister = _playerc.player_map_data_t_swigregister
player_map_data_t_swigregister(player_map_data_t)

class player_map_data_vector_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_map_data_vector_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_map_data_vector_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["minx"] = _playerc.player_map_data_vector_t_minx_set
    __swig_getmethods__["minx"] = _playerc.player_map_data_vector_t_minx_get
    if _newclass:minx = property(_playerc.player_map_data_vector_t_minx_get, _playerc.player_map_data_vector_t_minx_set)
    __swig_setmethods__["maxx"] = _playerc.player_map_data_vector_t_maxx_set
    __swig_getmethods__["maxx"] = _playerc.player_map_data_vector_t_maxx_get
    if _newclass:maxx = property(_playerc.player_map_data_vector_t_maxx_get, _playerc.player_map_data_vector_t_maxx_set)
    __swig_setmethods__["miny"] = _playerc.player_map_data_vector_t_miny_set
    __swig_getmethods__["miny"] = _playerc.player_map_data_vector_t_miny_get
    if _newclass:miny = property(_playerc.player_map_data_vector_t_miny_get, _playerc.player_map_data_vector_t_miny_set)
    __swig_setmethods__["maxy"] = _playerc.player_map_data_vector_t_maxy_set
    __swig_getmethods__["maxy"] = _playerc.player_map_data_vector_t_maxy_get
    if _newclass:maxy = property(_playerc.player_map_data_vector_t_maxy_get, _playerc.player_map_data_vector_t_maxy_set)
    __swig_setmethods__["segments_count"] = _playerc.player_map_data_vector_t_segments_count_set
    __swig_getmethods__["segments_count"] = _playerc.player_map_data_vector_t_segments_count_get
    if _newclass:segments_count = property(_playerc.player_map_data_vector_t_segments_count_get, _playerc.player_map_data_vector_t_segments_count_set)
    __swig_setmethods__["segments"] = _playerc.player_map_data_vector_t_segments_set
    __swig_getmethods__["segments"] = _playerc.player_map_data_vector_t_segments_get
    if _newclass:segments = property(_playerc.player_map_data_vector_t_segments_get, _playerc.player_map_data_vector_t_segments_set)
    def __init__(self, *args): 
        this = _playerc.new_player_map_data_vector_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_map_data_vector_t
    __del__ = lambda self : None;
player_map_data_vector_t_swigregister = _playerc.player_map_data_vector_t_swigregister
player_map_data_vector_t_swigregister(player_map_data_vector_t)

PLAYER_PLANNER_CODE = _playerc.PLAYER_PLANNER_CODE
PLAYER_PLANNER_STRING = _playerc.PLAYER_PLANNER_STRING
PLAYER_PLANNER_DATA_STATE = _playerc.PLAYER_PLANNER_DATA_STATE
PLAYER_PLANNER_CMD_GOAL = _playerc.PLAYER_PLANNER_CMD_GOAL
PLAYER_PLANNER_REQ_GET_WAYPOINTS = _playerc.PLAYER_PLANNER_REQ_GET_WAYPOINTS
PLAYER_PLANNER_REQ_ENABLE = _playerc.PLAYER_PLANNER_REQ_ENABLE
class player_planner_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_planner_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_planner_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["valid"] = _playerc.player_planner_data_t_valid_set
    __swig_getmethods__["valid"] = _playerc.player_planner_data_t_valid_get
    if _newclass:valid = property(_playerc.player_planner_data_t_valid_get, _playerc.player_planner_data_t_valid_set)
    __swig_setmethods__["done"] = _playerc.player_planner_data_t_done_set
    __swig_getmethods__["done"] = _playerc.player_planner_data_t_done_get
    if _newclass:done = property(_playerc.player_planner_data_t_done_get, _playerc.player_planner_data_t_done_set)
    __swig_setmethods__["pos"] = _playerc.player_planner_data_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_planner_data_t_pos_get
    if _newclass:pos = property(_playerc.player_planner_data_t_pos_get, _playerc.player_planner_data_t_pos_set)
    __swig_setmethods__["goal"] = _playerc.player_planner_data_t_goal_set
    __swig_getmethods__["goal"] = _playerc.player_planner_data_t_goal_get
    if _newclass:goal = property(_playerc.player_planner_data_t_goal_get, _playerc.player_planner_data_t_goal_set)
    __swig_setmethods__["waypoint"] = _playerc.player_planner_data_t_waypoint_set
    __swig_getmethods__["waypoint"] = _playerc.player_planner_data_t_waypoint_get
    if _newclass:waypoint = property(_playerc.player_planner_data_t_waypoint_get, _playerc.player_planner_data_t_waypoint_set)
    __swig_setmethods__["waypoint_idx"] = _playerc.player_planner_data_t_waypoint_idx_set
    __swig_getmethods__["waypoint_idx"] = _playerc.player_planner_data_t_waypoint_idx_get
    if _newclass:waypoint_idx = property(_playerc.player_planner_data_t_waypoint_idx_get, _playerc.player_planner_data_t_waypoint_idx_set)
    __swig_setmethods__["waypoints_count"] = _playerc.player_planner_data_t_waypoints_count_set
    __swig_getmethods__["waypoints_count"] = _playerc.player_planner_data_t_waypoints_count_get
    if _newclass:waypoints_count = property(_playerc.player_planner_data_t_waypoints_count_get, _playerc.player_planner_data_t_waypoints_count_set)
    def __init__(self, *args): 
        this = _playerc.new_player_planner_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_planner_data_t
    __del__ = lambda self : None;
player_planner_data_t_swigregister = _playerc.player_planner_data_t_swigregister
player_planner_data_t_swigregister(player_planner_data_t)

class player_planner_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_planner_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_planner_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["goal"] = _playerc.player_planner_cmd_t_goal_set
    __swig_getmethods__["goal"] = _playerc.player_planner_cmd_t_goal_get
    if _newclass:goal = property(_playerc.player_planner_cmd_t_goal_get, _playerc.player_planner_cmd_t_goal_set)
    def __init__(self, *args): 
        this = _playerc.new_player_planner_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_planner_cmd_t
    __del__ = lambda self : None;
player_planner_cmd_t_swigregister = _playerc.player_planner_cmd_t_swigregister
player_planner_cmd_t_swigregister(player_planner_cmd_t)

class player_planner_waypoints_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_planner_waypoints_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_planner_waypoints_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["waypoints_count"] = _playerc.player_planner_waypoints_req_t_waypoints_count_set
    __swig_getmethods__["waypoints_count"] = _playerc.player_planner_waypoints_req_t_waypoints_count_get
    if _newclass:waypoints_count = property(_playerc.player_planner_waypoints_req_t_waypoints_count_get, _playerc.player_planner_waypoints_req_t_waypoints_count_set)
    __swig_setmethods__["waypoints"] = _playerc.player_planner_waypoints_req_t_waypoints_set
    __swig_getmethods__["waypoints"] = _playerc.player_planner_waypoints_req_t_waypoints_get
    if _newclass:waypoints = property(_playerc.player_planner_waypoints_req_t_waypoints_get, _playerc.player_planner_waypoints_req_t_waypoints_set)
    def __init__(self, *args): 
        this = _playerc.new_player_planner_waypoints_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_planner_waypoints_req_t
    __del__ = lambda self : None;
player_planner_waypoints_req_t_swigregister = _playerc.player_planner_waypoints_req_t_swigregister
player_planner_waypoints_req_t_swigregister(player_planner_waypoints_req_t)

class player_planner_enable_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_planner_enable_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_planner_enable_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_planner_enable_req_t_state_set
    __swig_getmethods__["state"] = _playerc.player_planner_enable_req_t_state_get
    if _newclass:state = property(_playerc.player_planner_enable_req_t_state_get, _playerc.player_planner_enable_req_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_planner_enable_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_planner_enable_req_t
    __del__ = lambda self : None;
player_planner_enable_req_t_swigregister = _playerc.player_planner_enable_req_t_swigregister
player_planner_enable_req_t_swigregister(player_planner_enable_req_t)

PLAYER_LOG_CODE = _playerc.PLAYER_LOG_CODE
PLAYER_LOG_STRING = _playerc.PLAYER_LOG_STRING
PLAYER_LOG_REQ_SET_WRITE_STATE = _playerc.PLAYER_LOG_REQ_SET_WRITE_STATE
PLAYER_LOG_REQ_SET_READ_STATE = _playerc.PLAYER_LOG_REQ_SET_READ_STATE
PLAYER_LOG_REQ_GET_STATE = _playerc.PLAYER_LOG_REQ_GET_STATE
PLAYER_LOG_REQ_SET_READ_REWIND = _playerc.PLAYER_LOG_REQ_SET_READ_REWIND
PLAYER_LOG_REQ_SET_FILENAME = _playerc.PLAYER_LOG_REQ_SET_FILENAME
PLAYER_LOG_TYPE_READ = _playerc.PLAYER_LOG_TYPE_READ
PLAYER_LOG_TYPE_WRITE = _playerc.PLAYER_LOG_TYPE_WRITE
class player_log_set_write_state_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_log_set_write_state_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_log_set_write_state_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_log_set_write_state_t_state_set
    __swig_getmethods__["state"] = _playerc.player_log_set_write_state_t_state_get
    if _newclass:state = property(_playerc.player_log_set_write_state_t_state_get, _playerc.player_log_set_write_state_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_log_set_write_state_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_log_set_write_state_t
    __del__ = lambda self : None;
player_log_set_write_state_t_swigregister = _playerc.player_log_set_write_state_t_swigregister
player_log_set_write_state_t_swigregister(player_log_set_write_state_t)

class player_log_set_read_state_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_log_set_read_state_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_log_set_read_state_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_log_set_read_state_t_state_set
    __swig_getmethods__["state"] = _playerc.player_log_set_read_state_t_state_get
    if _newclass:state = property(_playerc.player_log_set_read_state_t_state_get, _playerc.player_log_set_read_state_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_log_set_read_state_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_log_set_read_state_t
    __del__ = lambda self : None;
player_log_set_read_state_t_swigregister = _playerc.player_log_set_read_state_t_swigregister
player_log_set_read_state_t_swigregister(player_log_set_read_state_t)

class player_log_get_state_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_log_get_state_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_log_get_state_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["type"] = _playerc.player_log_get_state_t_type_set
    __swig_getmethods__["type"] = _playerc.player_log_get_state_t_type_get
    if _newclass:type = property(_playerc.player_log_get_state_t_type_get, _playerc.player_log_get_state_t_type_set)
    __swig_setmethods__["state"] = _playerc.player_log_get_state_t_state_set
    __swig_getmethods__["state"] = _playerc.player_log_get_state_t_state_get
    if _newclass:state = property(_playerc.player_log_get_state_t_state_get, _playerc.player_log_get_state_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_log_get_state_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_log_get_state_t
    __del__ = lambda self : None;
player_log_get_state_t_swigregister = _playerc.player_log_get_state_t_swigregister
player_log_get_state_t_swigregister(player_log_get_state_t)

class player_log_set_filename_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_log_set_filename_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_log_set_filename_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["filename_count"] = _playerc.player_log_set_filename_t_filename_count_set
    __swig_getmethods__["filename_count"] = _playerc.player_log_set_filename_t_filename_count_get
    if _newclass:filename_count = property(_playerc.player_log_set_filename_t_filename_count_get, _playerc.player_log_set_filename_t_filename_count_set)
    __swig_setmethods__["filename"] = _playerc.player_log_set_filename_t_filename_set
    __swig_getmethods__["filename"] = _playerc.player_log_set_filename_t_filename_get
    if _newclass:filename = property(_playerc.player_log_set_filename_t_filename_get, _playerc.player_log_set_filename_t_filename_set)
    def __init__(self, *args): 
        this = _playerc.new_player_log_set_filename_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_log_set_filename_t
    __del__ = lambda self : None;
player_log_set_filename_t_swigregister = _playerc.player_log_set_filename_t_swigregister
player_log_set_filename_t_swigregister(player_log_set_filename_t)

PLAYER_JOYSTICK_CODE = _playerc.PLAYER_JOYSTICK_CODE
PLAYER_JOYSTICK_STRING = _playerc.PLAYER_JOYSTICK_STRING
PLAYER_JOYSTICK_DATA_STATE = _playerc.PLAYER_JOYSTICK_DATA_STATE
class player_joystick_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_joystick_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_joystick_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pos"] = _playerc.player_joystick_data_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_joystick_data_t_pos_get
    if _newclass:pos = property(_playerc.player_joystick_data_t_pos_get, _playerc.player_joystick_data_t_pos_set)
    __swig_setmethods__["scale"] = _playerc.player_joystick_data_t_scale_set
    __swig_getmethods__["scale"] = _playerc.player_joystick_data_t_scale_get
    if _newclass:scale = property(_playerc.player_joystick_data_t_scale_get, _playerc.player_joystick_data_t_scale_set)
    __swig_setmethods__["buttons"] = _playerc.player_joystick_data_t_buttons_set
    __swig_getmethods__["buttons"] = _playerc.player_joystick_data_t_buttons_get
    if _newclass:buttons = property(_playerc.player_joystick_data_t_buttons_get, _playerc.player_joystick_data_t_buttons_set)
    __swig_setmethods__["axes_count"] = _playerc.player_joystick_data_t_axes_count_set
    __swig_getmethods__["axes_count"] = _playerc.player_joystick_data_t_axes_count_get
    if _newclass:axes_count = property(_playerc.player_joystick_data_t_axes_count_get, _playerc.player_joystick_data_t_axes_count_set)
    def __init__(self, *args): 
        this = _playerc.new_player_joystick_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_joystick_data_t
    __del__ = lambda self : None;
player_joystick_data_t_swigregister = _playerc.player_joystick_data_t_swigregister
player_joystick_data_t_swigregister(player_joystick_data_t)

PLAYER_SPEECH_RECOGNITION_CODE = _playerc.PLAYER_SPEECH_RECOGNITION_CODE
PLAYER_SPEECH_RECOGNITION_STRING = _playerc.PLAYER_SPEECH_RECOGNITION_STRING
PLAYER_SPEECH_RECOGNITION_DATA_STRING = _playerc.PLAYER_SPEECH_RECOGNITION_DATA_STRING
class player_speech_recognition_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_speech_recognition_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_speech_recognition_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["text_count"] = _playerc.player_speech_recognition_data_t_text_count_set
    __swig_getmethods__["text_count"] = _playerc.player_speech_recognition_data_t_text_count_get
    if _newclass:text_count = property(_playerc.player_speech_recognition_data_t_text_count_get, _playerc.player_speech_recognition_data_t_text_count_set)
    __swig_setmethods__["text"] = _playerc.player_speech_recognition_data_t_text_set
    __swig_getmethods__["text"] = _playerc.player_speech_recognition_data_t_text_get
    if _newclass:text = property(_playerc.player_speech_recognition_data_t_text_get, _playerc.player_speech_recognition_data_t_text_set)
    def __init__(self, *args): 
        this = _playerc.new_player_speech_recognition_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_speech_recognition_data_t
    __del__ = lambda self : None;
player_speech_recognition_data_t_swigregister = _playerc.player_speech_recognition_data_t_swigregister
player_speech_recognition_data_t_swigregister(player_speech_recognition_data_t)

PLAYER_OPAQUE_CODE = _playerc.PLAYER_OPAQUE_CODE
PLAYER_OPAQUE_STRING = _playerc.PLAYER_OPAQUE_STRING
PLAYER_OPAQUE_DATA_STATE = _playerc.PLAYER_OPAQUE_DATA_STATE
PLAYER_OPAQUE_CMD_DATA = _playerc.PLAYER_OPAQUE_CMD_DATA
PLAYER_OPAQUE_REQ_DATA = _playerc.PLAYER_OPAQUE_REQ_DATA
PLAYER_OPAQUE_REQ = _playerc.PLAYER_OPAQUE_REQ
PLAYER_OPAQUE_CMD = _playerc.PLAYER_OPAQUE_CMD
class player_opaque_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_opaque_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_opaque_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["data_count"] = _playerc.player_opaque_data_t_data_count_set
    __swig_getmethods__["data_count"] = _playerc.player_opaque_data_t_data_count_get
    if _newclass:data_count = property(_playerc.player_opaque_data_t_data_count_get, _playerc.player_opaque_data_t_data_count_set)
    __swig_setmethods__["data"] = _playerc.player_opaque_data_t_data_set
    __swig_getmethods__["data"] = _playerc.player_opaque_data_t_data_get
    if _newclass:data = property(_playerc.player_opaque_data_t_data_get, _playerc.player_opaque_data_t_data_set)
    def __init__(self, *args): 
        this = _playerc.new_player_opaque_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_opaque_data_t
    __del__ = lambda self : None;
player_opaque_data_t_swigregister = _playerc.player_opaque_data_t_swigregister
player_opaque_data_t_swigregister(player_opaque_data_t)

PLAYER_POSITION1D_CODE = _playerc.PLAYER_POSITION1D_CODE
PLAYER_POSITION1D_STRING = _playerc.PLAYER_POSITION1D_STRING
PLAYER_POSITION1D_REQ_GET_GEOM = _playerc.PLAYER_POSITION1D_REQ_GET_GEOM
PLAYER_POSITION1D_REQ_MOTOR_POWER = _playerc.PLAYER_POSITION1D_REQ_MOTOR_POWER
PLAYER_POSITION1D_REQ_VELOCITY_MODE = _playerc.PLAYER_POSITION1D_REQ_VELOCITY_MODE
PLAYER_POSITION1D_REQ_POSITION_MODE = _playerc.PLAYER_POSITION1D_REQ_POSITION_MODE
PLAYER_POSITION1D_REQ_SET_ODOM = _playerc.PLAYER_POSITION1D_REQ_SET_ODOM
PLAYER_POSITION1D_REQ_RESET_ODOM = _playerc.PLAYER_POSITION1D_REQ_RESET_ODOM
PLAYER_POSITION1D_REQ_SPEED_PID = _playerc.PLAYER_POSITION1D_REQ_SPEED_PID
PLAYER_POSITION1D_REQ_POSITION_PID = _playerc.PLAYER_POSITION1D_REQ_POSITION_PID
PLAYER_POSITION1D_REQ_SPEED_PROF = _playerc.PLAYER_POSITION1D_REQ_SPEED_PROF
PLAYER_POSITION1D_DATA_STATE = _playerc.PLAYER_POSITION1D_DATA_STATE
PLAYER_POSITION1D_DATA_GEOM = _playerc.PLAYER_POSITION1D_DATA_GEOM
PLAYER_POSITION1D_CMD_VEL = _playerc.PLAYER_POSITION1D_CMD_VEL
PLAYER_POSITION1D_CMD_POS = _playerc.PLAYER_POSITION1D_CMD_POS
PLAYER_POSITION1D_STATUS_LIMIT_MIN = _playerc.PLAYER_POSITION1D_STATUS_LIMIT_MIN
PLAYER_POSITION1D_STATUS_LIMIT_CEN = _playerc.PLAYER_POSITION1D_STATUS_LIMIT_CEN
PLAYER_POSITION1D_STATUS_LIMIT_MAX = _playerc.PLAYER_POSITION1D_STATUS_LIMIT_MAX
PLAYER_POSITION1D_STATUS_OC = _playerc.PLAYER_POSITION1D_STATUS_OC
PLAYER_POSITION1D_STATUS_TRAJ_COMPLETE = _playerc.PLAYER_POSITION1D_STATUS_TRAJ_COMPLETE
PLAYER_POSITION1D_STATUS_ENABLED = _playerc.PLAYER_POSITION1D_STATUS_ENABLED
class player_position1d_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pos"] = _playerc.player_position1d_data_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_position1d_data_t_pos_get
    if _newclass:pos = property(_playerc.player_position1d_data_t_pos_get, _playerc.player_position1d_data_t_pos_set)
    __swig_setmethods__["vel"] = _playerc.player_position1d_data_t_vel_set
    __swig_getmethods__["vel"] = _playerc.player_position1d_data_t_vel_get
    if _newclass:vel = property(_playerc.player_position1d_data_t_vel_get, _playerc.player_position1d_data_t_vel_set)
    __swig_setmethods__["stall"] = _playerc.player_position1d_data_t_stall_set
    __swig_getmethods__["stall"] = _playerc.player_position1d_data_t_stall_get
    if _newclass:stall = property(_playerc.player_position1d_data_t_stall_get, _playerc.player_position1d_data_t_stall_set)
    __swig_setmethods__["status"] = _playerc.player_position1d_data_t_status_set
    __swig_getmethods__["status"] = _playerc.player_position1d_data_t_status_get
    if _newclass:status = property(_playerc.player_position1d_data_t_status_get, _playerc.player_position1d_data_t_status_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_data_t
    __del__ = lambda self : None;
player_position1d_data_t_swigregister = _playerc.player_position1d_data_t_swigregister
player_position1d_data_t_swigregister(player_position1d_data_t)

class player_position1d_cmd_vel_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_cmd_vel_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_cmd_vel_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["vel"] = _playerc.player_position1d_cmd_vel_t_vel_set
    __swig_getmethods__["vel"] = _playerc.player_position1d_cmd_vel_t_vel_get
    if _newclass:vel = property(_playerc.player_position1d_cmd_vel_t_vel_get, _playerc.player_position1d_cmd_vel_t_vel_set)
    __swig_setmethods__["state"] = _playerc.player_position1d_cmd_vel_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position1d_cmd_vel_t_state_get
    if _newclass:state = property(_playerc.player_position1d_cmd_vel_t_state_get, _playerc.player_position1d_cmd_vel_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_cmd_vel_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_cmd_vel_t
    __del__ = lambda self : None;
player_position1d_cmd_vel_t_swigregister = _playerc.player_position1d_cmd_vel_t_swigregister
player_position1d_cmd_vel_t_swigregister(player_position1d_cmd_vel_t)

class player_position1d_cmd_pos_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_cmd_pos_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_cmd_pos_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pos"] = _playerc.player_position1d_cmd_pos_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_position1d_cmd_pos_t_pos_get
    if _newclass:pos = property(_playerc.player_position1d_cmd_pos_t_pos_get, _playerc.player_position1d_cmd_pos_t_pos_set)
    __swig_setmethods__["vel"] = _playerc.player_position1d_cmd_pos_t_vel_set
    __swig_getmethods__["vel"] = _playerc.player_position1d_cmd_pos_t_vel_get
    if _newclass:vel = property(_playerc.player_position1d_cmd_pos_t_vel_get, _playerc.player_position1d_cmd_pos_t_vel_set)
    __swig_setmethods__["state"] = _playerc.player_position1d_cmd_pos_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position1d_cmd_pos_t_state_get
    if _newclass:state = property(_playerc.player_position1d_cmd_pos_t_state_get, _playerc.player_position1d_cmd_pos_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_cmd_pos_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_cmd_pos_t
    __del__ = lambda self : None;
player_position1d_cmd_pos_t_swigregister = _playerc.player_position1d_cmd_pos_t_swigregister
player_position1d_cmd_pos_t_swigregister(player_position1d_cmd_pos_t)

class player_position1d_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_position1d_geom_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_position1d_geom_t_pose_get
    if _newclass:pose = property(_playerc.player_position1d_geom_t_pose_get, _playerc.player_position1d_geom_t_pose_set)
    __swig_setmethods__["size"] = _playerc.player_position1d_geom_t_size_set
    __swig_getmethods__["size"] = _playerc.player_position1d_geom_t_size_get
    if _newclass:size = property(_playerc.player_position1d_geom_t_size_get, _playerc.player_position1d_geom_t_size_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_geom_t
    __del__ = lambda self : None;
player_position1d_geom_t_swigregister = _playerc.player_position1d_geom_t_swigregister
player_position1d_geom_t_swigregister(player_position1d_geom_t)

class player_position1d_power_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_power_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_power_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_position1d_power_config_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position1d_power_config_t_state_get
    if _newclass:state = property(_playerc.player_position1d_power_config_t_state_get, _playerc.player_position1d_power_config_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_power_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_power_config_t
    __del__ = lambda self : None;
player_position1d_power_config_t_swigregister = _playerc.player_position1d_power_config_t_swigregister
player_position1d_power_config_t_swigregister(player_position1d_power_config_t)

class player_position1d_velocity_mode_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_velocity_mode_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_velocity_mode_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_position1d_velocity_mode_config_t_value_set
    __swig_getmethods__["value"] = _playerc.player_position1d_velocity_mode_config_t_value_get
    if _newclass:value = property(_playerc.player_position1d_velocity_mode_config_t_value_get, _playerc.player_position1d_velocity_mode_config_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_velocity_mode_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_velocity_mode_config_t
    __del__ = lambda self : None;
player_position1d_velocity_mode_config_t_swigregister = _playerc.player_position1d_velocity_mode_config_t_swigregister
player_position1d_velocity_mode_config_t_swigregister(player_position1d_velocity_mode_config_t)

class player_position1d_reset_odom_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_reset_odom_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_reset_odom_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_position1d_reset_odom_config_t_value_set
    __swig_getmethods__["value"] = _playerc.player_position1d_reset_odom_config_t_value_get
    if _newclass:value = property(_playerc.player_position1d_reset_odom_config_t_value_get, _playerc.player_position1d_reset_odom_config_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_reset_odom_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_reset_odom_config_t
    __del__ = lambda self : None;
player_position1d_reset_odom_config_t_swigregister = _playerc.player_position1d_reset_odom_config_t_swigregister
player_position1d_reset_odom_config_t_swigregister(player_position1d_reset_odom_config_t)

class player_position1d_position_mode_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_position_mode_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_position_mode_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_position1d_position_mode_req_t_state_set
    __swig_getmethods__["state"] = _playerc.player_position1d_position_mode_req_t_state_get
    if _newclass:state = property(_playerc.player_position1d_position_mode_req_t_state_get, _playerc.player_position1d_position_mode_req_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_position_mode_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_position_mode_req_t
    __del__ = lambda self : None;
player_position1d_position_mode_req_t_swigregister = _playerc.player_position1d_position_mode_req_t_swigregister
player_position1d_position_mode_req_t_swigregister(player_position1d_position_mode_req_t)

class player_position1d_set_odom_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_set_odom_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_set_odom_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pos"] = _playerc.player_position1d_set_odom_req_t_pos_set
    __swig_getmethods__["pos"] = _playerc.player_position1d_set_odom_req_t_pos_get
    if _newclass:pos = property(_playerc.player_position1d_set_odom_req_t_pos_get, _playerc.player_position1d_set_odom_req_t_pos_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_set_odom_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_set_odom_req_t
    __del__ = lambda self : None;
player_position1d_set_odom_req_t_swigregister = _playerc.player_position1d_set_odom_req_t_swigregister
player_position1d_set_odom_req_t_swigregister(player_position1d_set_odom_req_t)

class player_position1d_speed_pid_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_speed_pid_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_speed_pid_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["kp"] = _playerc.player_position1d_speed_pid_req_t_kp_set
    __swig_getmethods__["kp"] = _playerc.player_position1d_speed_pid_req_t_kp_get
    if _newclass:kp = property(_playerc.player_position1d_speed_pid_req_t_kp_get, _playerc.player_position1d_speed_pid_req_t_kp_set)
    __swig_setmethods__["ki"] = _playerc.player_position1d_speed_pid_req_t_ki_set
    __swig_getmethods__["ki"] = _playerc.player_position1d_speed_pid_req_t_ki_get
    if _newclass:ki = property(_playerc.player_position1d_speed_pid_req_t_ki_get, _playerc.player_position1d_speed_pid_req_t_ki_set)
    __swig_setmethods__["kd"] = _playerc.player_position1d_speed_pid_req_t_kd_set
    __swig_getmethods__["kd"] = _playerc.player_position1d_speed_pid_req_t_kd_get
    if _newclass:kd = property(_playerc.player_position1d_speed_pid_req_t_kd_get, _playerc.player_position1d_speed_pid_req_t_kd_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_speed_pid_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_speed_pid_req_t
    __del__ = lambda self : None;
player_position1d_speed_pid_req_t_swigregister = _playerc.player_position1d_speed_pid_req_t_swigregister
player_position1d_speed_pid_req_t_swigregister(player_position1d_speed_pid_req_t)

class player_position1d_position_pid_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_position_pid_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_position_pid_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["kp"] = _playerc.player_position1d_position_pid_req_t_kp_set
    __swig_getmethods__["kp"] = _playerc.player_position1d_position_pid_req_t_kp_get
    if _newclass:kp = property(_playerc.player_position1d_position_pid_req_t_kp_get, _playerc.player_position1d_position_pid_req_t_kp_set)
    __swig_setmethods__["ki"] = _playerc.player_position1d_position_pid_req_t_ki_set
    __swig_getmethods__["ki"] = _playerc.player_position1d_position_pid_req_t_ki_get
    if _newclass:ki = property(_playerc.player_position1d_position_pid_req_t_ki_get, _playerc.player_position1d_position_pid_req_t_ki_set)
    __swig_setmethods__["kd"] = _playerc.player_position1d_position_pid_req_t_kd_set
    __swig_getmethods__["kd"] = _playerc.player_position1d_position_pid_req_t_kd_get
    if _newclass:kd = property(_playerc.player_position1d_position_pid_req_t_kd_get, _playerc.player_position1d_position_pid_req_t_kd_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_position_pid_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_position_pid_req_t
    __del__ = lambda self : None;
player_position1d_position_pid_req_t_swigregister = _playerc.player_position1d_position_pid_req_t_swigregister
player_position1d_position_pid_req_t_swigregister(player_position1d_position_pid_req_t)

class player_position1d_speed_prof_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_position1d_speed_prof_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_position1d_speed_prof_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["speed"] = _playerc.player_position1d_speed_prof_req_t_speed_set
    __swig_getmethods__["speed"] = _playerc.player_position1d_speed_prof_req_t_speed_get
    if _newclass:speed = property(_playerc.player_position1d_speed_prof_req_t_speed_get, _playerc.player_position1d_speed_prof_req_t_speed_set)
    __swig_setmethods__["acc"] = _playerc.player_position1d_speed_prof_req_t_acc_set
    __swig_getmethods__["acc"] = _playerc.player_position1d_speed_prof_req_t_acc_get
    if _newclass:acc = property(_playerc.player_position1d_speed_prof_req_t_acc_get, _playerc.player_position1d_speed_prof_req_t_acc_set)
    def __init__(self, *args): 
        this = _playerc.new_player_position1d_speed_prof_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_position1d_speed_prof_req_t
    __del__ = lambda self : None;
player_position1d_speed_prof_req_t_swigregister = _playerc.player_position1d_speed_prof_req_t_swigregister
player_position1d_speed_prof_req_t_swigregister(player_position1d_speed_prof_req_t)

PLAYER_ACTARRAY_CODE = _playerc.PLAYER_ACTARRAY_CODE
PLAYER_ACTARRAY_STRING = _playerc.PLAYER_ACTARRAY_STRING
PLAYER_ACTARRAY_REQ_POWER = _playerc.PLAYER_ACTARRAY_REQ_POWER
PLAYER_ACTARRAY_REQ_BRAKES = _playerc.PLAYER_ACTARRAY_REQ_BRAKES
PLAYER_ACTARRAY_REQ_GET_GEOM = _playerc.PLAYER_ACTARRAY_REQ_GET_GEOM
PLAYER_ACTARRAY_REQ_SPEED = _playerc.PLAYER_ACTARRAY_REQ_SPEED
PLAYER_ACTARRAY_REQ_ACCEL = _playerc.PLAYER_ACTARRAY_REQ_ACCEL
PLAYER_ACTARRAY_CMD_POS = _playerc.PLAYER_ACTARRAY_CMD_POS
PLAYER_ACTARRAY_CMD_MULTI_POS = _playerc.PLAYER_ACTARRAY_CMD_MULTI_POS
PLAYER_ACTARRAY_CMD_SPEED = _playerc.PLAYER_ACTARRAY_CMD_SPEED
PLAYER_ACTARRAY_CMD_MULTI_SPEED = _playerc.PLAYER_ACTARRAY_CMD_MULTI_SPEED
PLAYER_ACTARRAY_CMD_HOME = _playerc.PLAYER_ACTARRAY_CMD_HOME
PLAYER_ACTARRAY_CMD_CURRENT = _playerc.PLAYER_ACTARRAY_CMD_CURRENT
PLAYER_ACTARRAY_CMD_MULTI_CURRENT = _playerc.PLAYER_ACTARRAY_CMD_MULTI_CURRENT
PLAYER_ACTARRAY_DATA_STATE = _playerc.PLAYER_ACTARRAY_DATA_STATE
PLAYER_ACTARRAY_ACTSTATE_IDLE = _playerc.PLAYER_ACTARRAY_ACTSTATE_IDLE
PLAYER_ACTARRAY_ACTSTATE_MOVING = _playerc.PLAYER_ACTARRAY_ACTSTATE_MOVING
PLAYER_ACTARRAY_ACTSTATE_BRAKED = _playerc.PLAYER_ACTARRAY_ACTSTATE_BRAKED
PLAYER_ACTARRAY_ACTSTATE_STALLED = _playerc.PLAYER_ACTARRAY_ACTSTATE_STALLED
PLAYER_ACTARRAY_TYPE_LINEAR = _playerc.PLAYER_ACTARRAY_TYPE_LINEAR
PLAYER_ACTARRAY_TYPE_ROTARY = _playerc.PLAYER_ACTARRAY_TYPE_ROTARY
class player_actarray_actuator_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_actuator_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_actuator_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["position"] = _playerc.player_actarray_actuator_t_position_set
    __swig_getmethods__["position"] = _playerc.player_actarray_actuator_t_position_get
    if _newclass:position = property(_playerc.player_actarray_actuator_t_position_get, _playerc.player_actarray_actuator_t_position_set)
    __swig_setmethods__["speed"] = _playerc.player_actarray_actuator_t_speed_set
    __swig_getmethods__["speed"] = _playerc.player_actarray_actuator_t_speed_get
    if _newclass:speed = property(_playerc.player_actarray_actuator_t_speed_get, _playerc.player_actarray_actuator_t_speed_set)
    __swig_setmethods__["acceleration"] = _playerc.player_actarray_actuator_t_acceleration_set
    __swig_getmethods__["acceleration"] = _playerc.player_actarray_actuator_t_acceleration_get
    if _newclass:acceleration = property(_playerc.player_actarray_actuator_t_acceleration_get, _playerc.player_actarray_actuator_t_acceleration_set)
    __swig_setmethods__["current"] = _playerc.player_actarray_actuator_t_current_set
    __swig_getmethods__["current"] = _playerc.player_actarray_actuator_t_current_get
    if _newclass:current = property(_playerc.player_actarray_actuator_t_current_get, _playerc.player_actarray_actuator_t_current_set)
    __swig_setmethods__["state"] = _playerc.player_actarray_actuator_t_state_set
    __swig_getmethods__["state"] = _playerc.player_actarray_actuator_t_state_get
    if _newclass:state = property(_playerc.player_actarray_actuator_t_state_get, _playerc.player_actarray_actuator_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_actuator_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_actuator_t
    __del__ = lambda self : None;
player_actarray_actuator_t_swigregister = _playerc.player_actarray_actuator_t_swigregister
player_actarray_actuator_t_swigregister(player_actarray_actuator_t)

class player_actarray_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["actuators_count"] = _playerc.player_actarray_data_t_actuators_count_set
    __swig_getmethods__["actuators_count"] = _playerc.player_actarray_data_t_actuators_count_get
    if _newclass:actuators_count = property(_playerc.player_actarray_data_t_actuators_count_get, _playerc.player_actarray_data_t_actuators_count_set)
    __swig_setmethods__["actuators"] = _playerc.player_actarray_data_t_actuators_set
    __swig_getmethods__["actuators"] = _playerc.player_actarray_data_t_actuators_get
    if _newclass:actuators = property(_playerc.player_actarray_data_t_actuators_get, _playerc.player_actarray_data_t_actuators_set)
    __swig_setmethods__["motor_state"] = _playerc.player_actarray_data_t_motor_state_set
    __swig_getmethods__["motor_state"] = _playerc.player_actarray_data_t_motor_state_get
    if _newclass:motor_state = property(_playerc.player_actarray_data_t_motor_state_get, _playerc.player_actarray_data_t_motor_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_data_t
    __del__ = lambda self : None;
player_actarray_data_t_swigregister = _playerc.player_actarray_data_t_swigregister
player_actarray_data_t_swigregister(player_actarray_data_t)

class player_actarray_actuatorgeom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_actuatorgeom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_actuatorgeom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["type"] = _playerc.player_actarray_actuatorgeom_t_type_set
    __swig_getmethods__["type"] = _playerc.player_actarray_actuatorgeom_t_type_get
    if _newclass:type = property(_playerc.player_actarray_actuatorgeom_t_type_get, _playerc.player_actarray_actuatorgeom_t_type_set)
    __swig_setmethods__["length"] = _playerc.player_actarray_actuatorgeom_t_length_set
    __swig_getmethods__["length"] = _playerc.player_actarray_actuatorgeom_t_length_get
    if _newclass:length = property(_playerc.player_actarray_actuatorgeom_t_length_get, _playerc.player_actarray_actuatorgeom_t_length_set)
    __swig_setmethods__["orientation"] = _playerc.player_actarray_actuatorgeom_t_orientation_set
    __swig_getmethods__["orientation"] = _playerc.player_actarray_actuatorgeom_t_orientation_get
    if _newclass:orientation = property(_playerc.player_actarray_actuatorgeom_t_orientation_get, _playerc.player_actarray_actuatorgeom_t_orientation_set)
    __swig_setmethods__["axis"] = _playerc.player_actarray_actuatorgeom_t_axis_set
    __swig_getmethods__["axis"] = _playerc.player_actarray_actuatorgeom_t_axis_get
    if _newclass:axis = property(_playerc.player_actarray_actuatorgeom_t_axis_get, _playerc.player_actarray_actuatorgeom_t_axis_set)
    __swig_setmethods__["min"] = _playerc.player_actarray_actuatorgeom_t_min_set
    __swig_getmethods__["min"] = _playerc.player_actarray_actuatorgeom_t_min_get
    if _newclass:min = property(_playerc.player_actarray_actuatorgeom_t_min_get, _playerc.player_actarray_actuatorgeom_t_min_set)
    __swig_setmethods__["centre"] = _playerc.player_actarray_actuatorgeom_t_centre_set
    __swig_getmethods__["centre"] = _playerc.player_actarray_actuatorgeom_t_centre_get
    if _newclass:centre = property(_playerc.player_actarray_actuatorgeom_t_centre_get, _playerc.player_actarray_actuatorgeom_t_centre_set)
    __swig_setmethods__["max"] = _playerc.player_actarray_actuatorgeom_t_max_set
    __swig_getmethods__["max"] = _playerc.player_actarray_actuatorgeom_t_max_get
    if _newclass:max = property(_playerc.player_actarray_actuatorgeom_t_max_get, _playerc.player_actarray_actuatorgeom_t_max_set)
    __swig_setmethods__["home"] = _playerc.player_actarray_actuatorgeom_t_home_set
    __swig_getmethods__["home"] = _playerc.player_actarray_actuatorgeom_t_home_get
    if _newclass:home = property(_playerc.player_actarray_actuatorgeom_t_home_get, _playerc.player_actarray_actuatorgeom_t_home_set)
    __swig_setmethods__["config_speed"] = _playerc.player_actarray_actuatorgeom_t_config_speed_set
    __swig_getmethods__["config_speed"] = _playerc.player_actarray_actuatorgeom_t_config_speed_get
    if _newclass:config_speed = property(_playerc.player_actarray_actuatorgeom_t_config_speed_get, _playerc.player_actarray_actuatorgeom_t_config_speed_set)
    __swig_setmethods__["hasbrakes"] = _playerc.player_actarray_actuatorgeom_t_hasbrakes_set
    __swig_getmethods__["hasbrakes"] = _playerc.player_actarray_actuatorgeom_t_hasbrakes_get
    if _newclass:hasbrakes = property(_playerc.player_actarray_actuatorgeom_t_hasbrakes_get, _playerc.player_actarray_actuatorgeom_t_hasbrakes_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_actuatorgeom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_actuatorgeom_t
    __del__ = lambda self : None;
player_actarray_actuatorgeom_t_swigregister = _playerc.player_actarray_actuatorgeom_t_swigregister
player_actarray_actuatorgeom_t_swigregister(player_actarray_actuatorgeom_t)

class player_actarray_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["actuators_count"] = _playerc.player_actarray_geom_t_actuators_count_set
    __swig_getmethods__["actuators_count"] = _playerc.player_actarray_geom_t_actuators_count_get
    if _newclass:actuators_count = property(_playerc.player_actarray_geom_t_actuators_count_get, _playerc.player_actarray_geom_t_actuators_count_set)
    __swig_setmethods__["actuators"] = _playerc.player_actarray_geom_t_actuators_set
    __swig_getmethods__["actuators"] = _playerc.player_actarray_geom_t_actuators_get
    if _newclass:actuators = property(_playerc.player_actarray_geom_t_actuators_get, _playerc.player_actarray_geom_t_actuators_set)
    __swig_setmethods__["base_pos"] = _playerc.player_actarray_geom_t_base_pos_set
    __swig_getmethods__["base_pos"] = _playerc.player_actarray_geom_t_base_pos_get
    if _newclass:base_pos = property(_playerc.player_actarray_geom_t_base_pos_get, _playerc.player_actarray_geom_t_base_pos_set)
    __swig_setmethods__["base_orientation"] = _playerc.player_actarray_geom_t_base_orientation_set
    __swig_getmethods__["base_orientation"] = _playerc.player_actarray_geom_t_base_orientation_get
    if _newclass:base_orientation = property(_playerc.player_actarray_geom_t_base_orientation_get, _playerc.player_actarray_geom_t_base_orientation_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_geom_t
    __del__ = lambda self : None;
player_actarray_geom_t_swigregister = _playerc.player_actarray_geom_t_swigregister
player_actarray_geom_t_swigregister(player_actarray_geom_t)

class player_actarray_position_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_position_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_position_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["joint"] = _playerc.player_actarray_position_cmd_t_joint_set
    __swig_getmethods__["joint"] = _playerc.player_actarray_position_cmd_t_joint_get
    if _newclass:joint = property(_playerc.player_actarray_position_cmd_t_joint_get, _playerc.player_actarray_position_cmd_t_joint_set)
    __swig_setmethods__["position"] = _playerc.player_actarray_position_cmd_t_position_set
    __swig_getmethods__["position"] = _playerc.player_actarray_position_cmd_t_position_get
    if _newclass:position = property(_playerc.player_actarray_position_cmd_t_position_get, _playerc.player_actarray_position_cmd_t_position_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_position_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_position_cmd_t
    __del__ = lambda self : None;
player_actarray_position_cmd_t_swigregister = _playerc.player_actarray_position_cmd_t_swigregister
player_actarray_position_cmd_t_swigregister(player_actarray_position_cmd_t)

class player_actarray_multi_position_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_multi_position_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_multi_position_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["positions_count"] = _playerc.player_actarray_multi_position_cmd_t_positions_count_set
    __swig_getmethods__["positions_count"] = _playerc.player_actarray_multi_position_cmd_t_positions_count_get
    if _newclass:positions_count = property(_playerc.player_actarray_multi_position_cmd_t_positions_count_get, _playerc.player_actarray_multi_position_cmd_t_positions_count_set)
    __swig_setmethods__["positions"] = _playerc.player_actarray_multi_position_cmd_t_positions_set
    __swig_getmethods__["positions"] = _playerc.player_actarray_multi_position_cmd_t_positions_get
    if _newclass:positions = property(_playerc.player_actarray_multi_position_cmd_t_positions_get, _playerc.player_actarray_multi_position_cmd_t_positions_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_multi_position_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_multi_position_cmd_t
    __del__ = lambda self : None;
player_actarray_multi_position_cmd_t_swigregister = _playerc.player_actarray_multi_position_cmd_t_swigregister
player_actarray_multi_position_cmd_t_swigregister(player_actarray_multi_position_cmd_t)

class player_actarray_speed_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_speed_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_speed_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["joint"] = _playerc.player_actarray_speed_cmd_t_joint_set
    __swig_getmethods__["joint"] = _playerc.player_actarray_speed_cmd_t_joint_get
    if _newclass:joint = property(_playerc.player_actarray_speed_cmd_t_joint_get, _playerc.player_actarray_speed_cmd_t_joint_set)
    __swig_setmethods__["speed"] = _playerc.player_actarray_speed_cmd_t_speed_set
    __swig_getmethods__["speed"] = _playerc.player_actarray_speed_cmd_t_speed_get
    if _newclass:speed = property(_playerc.player_actarray_speed_cmd_t_speed_get, _playerc.player_actarray_speed_cmd_t_speed_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_speed_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_speed_cmd_t
    __del__ = lambda self : None;
player_actarray_speed_cmd_t_swigregister = _playerc.player_actarray_speed_cmd_t_swigregister
player_actarray_speed_cmd_t_swigregister(player_actarray_speed_cmd_t)

class player_actarray_multi_speed_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_multi_speed_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_multi_speed_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["speeds_count"] = _playerc.player_actarray_multi_speed_cmd_t_speeds_count_set
    __swig_getmethods__["speeds_count"] = _playerc.player_actarray_multi_speed_cmd_t_speeds_count_get
    if _newclass:speeds_count = property(_playerc.player_actarray_multi_speed_cmd_t_speeds_count_get, _playerc.player_actarray_multi_speed_cmd_t_speeds_count_set)
    __swig_setmethods__["speeds"] = _playerc.player_actarray_multi_speed_cmd_t_speeds_set
    __swig_getmethods__["speeds"] = _playerc.player_actarray_multi_speed_cmd_t_speeds_get
    if _newclass:speeds = property(_playerc.player_actarray_multi_speed_cmd_t_speeds_get, _playerc.player_actarray_multi_speed_cmd_t_speeds_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_multi_speed_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_multi_speed_cmd_t
    __del__ = lambda self : None;
player_actarray_multi_speed_cmd_t_swigregister = _playerc.player_actarray_multi_speed_cmd_t_swigregister
player_actarray_multi_speed_cmd_t_swigregister(player_actarray_multi_speed_cmd_t)

class player_actarray_home_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_home_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_home_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["joint"] = _playerc.player_actarray_home_cmd_t_joint_set
    __swig_getmethods__["joint"] = _playerc.player_actarray_home_cmd_t_joint_get
    if _newclass:joint = property(_playerc.player_actarray_home_cmd_t_joint_get, _playerc.player_actarray_home_cmd_t_joint_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_home_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_home_cmd_t
    __del__ = lambda self : None;
player_actarray_home_cmd_t_swigregister = _playerc.player_actarray_home_cmd_t_swigregister
player_actarray_home_cmd_t_swigregister(player_actarray_home_cmd_t)

class player_actarray_current_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_current_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_current_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["joint"] = _playerc.player_actarray_current_cmd_t_joint_set
    __swig_getmethods__["joint"] = _playerc.player_actarray_current_cmd_t_joint_get
    if _newclass:joint = property(_playerc.player_actarray_current_cmd_t_joint_get, _playerc.player_actarray_current_cmd_t_joint_set)
    __swig_setmethods__["current"] = _playerc.player_actarray_current_cmd_t_current_set
    __swig_getmethods__["current"] = _playerc.player_actarray_current_cmd_t_current_get
    if _newclass:current = property(_playerc.player_actarray_current_cmd_t_current_get, _playerc.player_actarray_current_cmd_t_current_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_current_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_current_cmd_t
    __del__ = lambda self : None;
player_actarray_current_cmd_t_swigregister = _playerc.player_actarray_current_cmd_t_swigregister
player_actarray_current_cmd_t_swigregister(player_actarray_current_cmd_t)

class player_actarray_multi_current_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_multi_current_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_multi_current_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["currents_count"] = _playerc.player_actarray_multi_current_cmd_t_currents_count_set
    __swig_getmethods__["currents_count"] = _playerc.player_actarray_multi_current_cmd_t_currents_count_get
    if _newclass:currents_count = property(_playerc.player_actarray_multi_current_cmd_t_currents_count_get, _playerc.player_actarray_multi_current_cmd_t_currents_count_set)
    __swig_setmethods__["currents"] = _playerc.player_actarray_multi_current_cmd_t_currents_set
    __swig_getmethods__["currents"] = _playerc.player_actarray_multi_current_cmd_t_currents_get
    if _newclass:currents = property(_playerc.player_actarray_multi_current_cmd_t_currents_get, _playerc.player_actarray_multi_current_cmd_t_currents_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_multi_current_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_multi_current_cmd_t
    __del__ = lambda self : None;
player_actarray_multi_current_cmd_t_swigregister = _playerc.player_actarray_multi_current_cmd_t_swigregister
player_actarray_multi_current_cmd_t_swigregister(player_actarray_multi_current_cmd_t)

class player_actarray_power_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_power_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_power_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_actarray_power_config_t_value_set
    __swig_getmethods__["value"] = _playerc.player_actarray_power_config_t_value_get
    if _newclass:value = property(_playerc.player_actarray_power_config_t_value_get, _playerc.player_actarray_power_config_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_power_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_power_config_t
    __del__ = lambda self : None;
player_actarray_power_config_t_swigregister = _playerc.player_actarray_power_config_t_swigregister
player_actarray_power_config_t_swigregister(player_actarray_power_config_t)

class player_actarray_brakes_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_brakes_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_brakes_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_actarray_brakes_config_t_value_set
    __swig_getmethods__["value"] = _playerc.player_actarray_brakes_config_t_value_get
    if _newclass:value = property(_playerc.player_actarray_brakes_config_t_value_get, _playerc.player_actarray_brakes_config_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_brakes_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_brakes_config_t
    __del__ = lambda self : None;
player_actarray_brakes_config_t_swigregister = _playerc.player_actarray_brakes_config_t_swigregister
player_actarray_brakes_config_t_swigregister(player_actarray_brakes_config_t)

class player_actarray_speed_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_speed_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_speed_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["joint"] = _playerc.player_actarray_speed_config_t_joint_set
    __swig_getmethods__["joint"] = _playerc.player_actarray_speed_config_t_joint_get
    if _newclass:joint = property(_playerc.player_actarray_speed_config_t_joint_get, _playerc.player_actarray_speed_config_t_joint_set)
    __swig_setmethods__["speed"] = _playerc.player_actarray_speed_config_t_speed_set
    __swig_getmethods__["speed"] = _playerc.player_actarray_speed_config_t_speed_get
    if _newclass:speed = property(_playerc.player_actarray_speed_config_t_speed_get, _playerc.player_actarray_speed_config_t_speed_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_speed_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_speed_config_t
    __del__ = lambda self : None;
player_actarray_speed_config_t_swigregister = _playerc.player_actarray_speed_config_t_swigregister
player_actarray_speed_config_t_swigregister(player_actarray_speed_config_t)

class player_actarray_accel_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_actarray_accel_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_actarray_accel_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["joint"] = _playerc.player_actarray_accel_config_t_joint_set
    __swig_getmethods__["joint"] = _playerc.player_actarray_accel_config_t_joint_get
    if _newclass:joint = property(_playerc.player_actarray_accel_config_t_joint_get, _playerc.player_actarray_accel_config_t_joint_set)
    __swig_setmethods__["accel"] = _playerc.player_actarray_accel_config_t_accel_set
    __swig_getmethods__["accel"] = _playerc.player_actarray_accel_config_t_accel_get
    if _newclass:accel = property(_playerc.player_actarray_accel_config_t_accel_get, _playerc.player_actarray_accel_config_t_accel_set)
    def __init__(self, *args): 
        this = _playerc.new_player_actarray_accel_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_actarray_accel_config_t
    __del__ = lambda self : None;
player_actarray_accel_config_t_swigregister = _playerc.player_actarray_accel_config_t_swigregister
player_actarray_accel_config_t_swigregister(player_actarray_accel_config_t)

PLAYER_LIMB_CODE = _playerc.PLAYER_LIMB_CODE
PLAYER_LIMB_STRING = _playerc.PLAYER_LIMB_STRING
PLAYER_LIMB_STATE_IDLE = _playerc.PLAYER_LIMB_STATE_IDLE
PLAYER_LIMB_STATE_BRAKED = _playerc.PLAYER_LIMB_STATE_BRAKED
PLAYER_LIMB_STATE_MOVING = _playerc.PLAYER_LIMB_STATE_MOVING
PLAYER_LIMB_STATE_OOR = _playerc.PLAYER_LIMB_STATE_OOR
PLAYER_LIMB_STATE_COLL = _playerc.PLAYER_LIMB_STATE_COLL
PLAYER_LIMB_DATA_STATE = _playerc.PLAYER_LIMB_DATA_STATE
PLAYER_LIMB_CMD_HOME = _playerc.PLAYER_LIMB_CMD_HOME
PLAYER_LIMB_CMD_STOP = _playerc.PLAYER_LIMB_CMD_STOP
PLAYER_LIMB_CMD_SETPOSE = _playerc.PLAYER_LIMB_CMD_SETPOSE
PLAYER_LIMB_CMD_SETPOSITION = _playerc.PLAYER_LIMB_CMD_SETPOSITION
PLAYER_LIMB_CMD_VECMOVE = _playerc.PLAYER_LIMB_CMD_VECMOVE
PLAYER_LIMB_REQ_POWER = _playerc.PLAYER_LIMB_REQ_POWER
PLAYER_LIMB_REQ_BRAKES = _playerc.PLAYER_LIMB_REQ_BRAKES
PLAYER_LIMB_REQ_GEOM = _playerc.PLAYER_LIMB_REQ_GEOM
PLAYER_LIMB_REQ_SPEED = _playerc.PLAYER_LIMB_REQ_SPEED
class player_limb_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_limb_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_limb_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["position"] = _playerc.player_limb_data_t_position_set
    __swig_getmethods__["position"] = _playerc.player_limb_data_t_position_get
    if _newclass:position = property(_playerc.player_limb_data_t_position_get, _playerc.player_limb_data_t_position_set)
    __swig_setmethods__["approach"] = _playerc.player_limb_data_t_approach_set
    __swig_getmethods__["approach"] = _playerc.player_limb_data_t_approach_get
    if _newclass:approach = property(_playerc.player_limb_data_t_approach_get, _playerc.player_limb_data_t_approach_set)
    __swig_setmethods__["orientation"] = _playerc.player_limb_data_t_orientation_set
    __swig_getmethods__["orientation"] = _playerc.player_limb_data_t_orientation_get
    if _newclass:orientation = property(_playerc.player_limb_data_t_orientation_get, _playerc.player_limb_data_t_orientation_set)
    __swig_setmethods__["state"] = _playerc.player_limb_data_t_state_set
    __swig_getmethods__["state"] = _playerc.player_limb_data_t_state_get
    if _newclass:state = property(_playerc.player_limb_data_t_state_get, _playerc.player_limb_data_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_limb_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_limb_data_t
    __del__ = lambda self : None;
player_limb_data_t_swigregister = _playerc.player_limb_data_t_swigregister
player_limb_data_t_swigregister(player_limb_data_t)

class player_limb_setpose_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_limb_setpose_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_limb_setpose_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["position"] = _playerc.player_limb_setpose_cmd_t_position_set
    __swig_getmethods__["position"] = _playerc.player_limb_setpose_cmd_t_position_get
    if _newclass:position = property(_playerc.player_limb_setpose_cmd_t_position_get, _playerc.player_limb_setpose_cmd_t_position_set)
    __swig_setmethods__["approach"] = _playerc.player_limb_setpose_cmd_t_approach_set
    __swig_getmethods__["approach"] = _playerc.player_limb_setpose_cmd_t_approach_get
    if _newclass:approach = property(_playerc.player_limb_setpose_cmd_t_approach_get, _playerc.player_limb_setpose_cmd_t_approach_set)
    __swig_setmethods__["orientation"] = _playerc.player_limb_setpose_cmd_t_orientation_set
    __swig_getmethods__["orientation"] = _playerc.player_limb_setpose_cmd_t_orientation_get
    if _newclass:orientation = property(_playerc.player_limb_setpose_cmd_t_orientation_get, _playerc.player_limb_setpose_cmd_t_orientation_set)
    def __init__(self, *args): 
        this = _playerc.new_player_limb_setpose_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_limb_setpose_cmd_t
    __del__ = lambda self : None;
player_limb_setpose_cmd_t_swigregister = _playerc.player_limb_setpose_cmd_t_swigregister
player_limb_setpose_cmd_t_swigregister(player_limb_setpose_cmd_t)

class player_limb_setposition_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_limb_setposition_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_limb_setposition_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["position"] = _playerc.player_limb_setposition_cmd_t_position_set
    __swig_getmethods__["position"] = _playerc.player_limb_setposition_cmd_t_position_get
    if _newclass:position = property(_playerc.player_limb_setposition_cmd_t_position_get, _playerc.player_limb_setposition_cmd_t_position_set)
    def __init__(self, *args): 
        this = _playerc.new_player_limb_setposition_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_limb_setposition_cmd_t
    __del__ = lambda self : None;
player_limb_setposition_cmd_t_swigregister = _playerc.player_limb_setposition_cmd_t_swigregister
player_limb_setposition_cmd_t_swigregister(player_limb_setposition_cmd_t)

class player_limb_vecmove_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_limb_vecmove_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_limb_vecmove_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["direction"] = _playerc.player_limb_vecmove_cmd_t_direction_set
    __swig_getmethods__["direction"] = _playerc.player_limb_vecmove_cmd_t_direction_get
    if _newclass:direction = property(_playerc.player_limb_vecmove_cmd_t_direction_get, _playerc.player_limb_vecmove_cmd_t_direction_set)
    __swig_setmethods__["length"] = _playerc.player_limb_vecmove_cmd_t_length_set
    __swig_getmethods__["length"] = _playerc.player_limb_vecmove_cmd_t_length_get
    if _newclass:length = property(_playerc.player_limb_vecmove_cmd_t_length_get, _playerc.player_limb_vecmove_cmd_t_length_set)
    def __init__(self, *args): 
        this = _playerc.new_player_limb_vecmove_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_limb_vecmove_cmd_t
    __del__ = lambda self : None;
player_limb_vecmove_cmd_t_swigregister = _playerc.player_limb_vecmove_cmd_t_swigregister
player_limb_vecmove_cmd_t_swigregister(player_limb_vecmove_cmd_t)

class player_limb_power_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_limb_power_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_limb_power_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_limb_power_req_t_value_set
    __swig_getmethods__["value"] = _playerc.player_limb_power_req_t_value_get
    if _newclass:value = property(_playerc.player_limb_power_req_t_value_get, _playerc.player_limb_power_req_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_limb_power_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_limb_power_req_t
    __del__ = lambda self : None;
player_limb_power_req_t_swigregister = _playerc.player_limb_power_req_t_swigregister
player_limb_power_req_t_swigregister(player_limb_power_req_t)

class player_limb_brakes_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_limb_brakes_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_limb_brakes_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_limb_brakes_req_t_value_set
    __swig_getmethods__["value"] = _playerc.player_limb_brakes_req_t_value_get
    if _newclass:value = property(_playerc.player_limb_brakes_req_t_value_get, _playerc.player_limb_brakes_req_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_limb_brakes_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_limb_brakes_req_t
    __del__ = lambda self : None;
player_limb_brakes_req_t_swigregister = _playerc.player_limb_brakes_req_t_swigregister
player_limb_brakes_req_t_swigregister(player_limb_brakes_req_t)

class player_limb_geom_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_limb_geom_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_limb_geom_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["basePos"] = _playerc.player_limb_geom_req_t_basePos_set
    __swig_getmethods__["basePos"] = _playerc.player_limb_geom_req_t_basePos_get
    if _newclass:basePos = property(_playerc.player_limb_geom_req_t_basePos_get, _playerc.player_limb_geom_req_t_basePos_set)
    def __init__(self, *args): 
        this = _playerc.new_player_limb_geom_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_limb_geom_req_t
    __del__ = lambda self : None;
player_limb_geom_req_t_swigregister = _playerc.player_limb_geom_req_t_swigregister
player_limb_geom_req_t_swigregister(player_limb_geom_req_t)

class player_limb_speed_req_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_limb_speed_req_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_limb_speed_req_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["speed"] = _playerc.player_limb_speed_req_t_speed_set
    __swig_getmethods__["speed"] = _playerc.player_limb_speed_req_t_speed_get
    if _newclass:speed = property(_playerc.player_limb_speed_req_t_speed_get, _playerc.player_limb_speed_req_t_speed_set)
    def __init__(self, *args): 
        this = _playerc.new_player_limb_speed_req_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_limb_speed_req_t
    __del__ = lambda self : None;
player_limb_speed_req_t_swigregister = _playerc.player_limb_speed_req_t_swigregister
player_limb_speed_req_t_swigregister(player_limb_speed_req_t)

PLAYER_GRAPHICS2D_CODE = _playerc.PLAYER_GRAPHICS2D_CODE
PLAYER_GRAPHICS2D_STRING = _playerc.PLAYER_GRAPHICS2D_STRING
PLAYER_GRAPHICS2D_CMD_CLEAR = _playerc.PLAYER_GRAPHICS2D_CMD_CLEAR
PLAYER_GRAPHICS2D_CMD_POINTS = _playerc.PLAYER_GRAPHICS2D_CMD_POINTS
PLAYER_GRAPHICS2D_CMD_POLYLINE = _playerc.PLAYER_GRAPHICS2D_CMD_POLYLINE
PLAYER_GRAPHICS2D_CMD_POLYGON = _playerc.PLAYER_GRAPHICS2D_CMD_POLYGON
class player_graphics2d_cmd_points_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_graphics2d_cmd_points_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_graphics2d_cmd_points_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["points_count"] = _playerc.player_graphics2d_cmd_points_t_points_count_set
    __swig_getmethods__["points_count"] = _playerc.player_graphics2d_cmd_points_t_points_count_get
    if _newclass:points_count = property(_playerc.player_graphics2d_cmd_points_t_points_count_get, _playerc.player_graphics2d_cmd_points_t_points_count_set)
    __swig_setmethods__["points"] = _playerc.player_graphics2d_cmd_points_t_points_set
    __swig_getmethods__["points"] = _playerc.player_graphics2d_cmd_points_t_points_get
    if _newclass:points = property(_playerc.player_graphics2d_cmd_points_t_points_get, _playerc.player_graphics2d_cmd_points_t_points_set)
    __swig_setmethods__["color"] = _playerc.player_graphics2d_cmd_points_t_color_set
    __swig_getmethods__["color"] = _playerc.player_graphics2d_cmd_points_t_color_get
    if _newclass:color = property(_playerc.player_graphics2d_cmd_points_t_color_get, _playerc.player_graphics2d_cmd_points_t_color_set)
    def __init__(self, *args): 
        this = _playerc.new_player_graphics2d_cmd_points_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_graphics2d_cmd_points_t
    __del__ = lambda self : None;
player_graphics2d_cmd_points_t_swigregister = _playerc.player_graphics2d_cmd_points_t_swigregister
player_graphics2d_cmd_points_t_swigregister(player_graphics2d_cmd_points_t)

class player_graphics2d_cmd_polyline_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_graphics2d_cmd_polyline_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_graphics2d_cmd_polyline_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["points_count"] = _playerc.player_graphics2d_cmd_polyline_t_points_count_set
    __swig_getmethods__["points_count"] = _playerc.player_graphics2d_cmd_polyline_t_points_count_get
    if _newclass:points_count = property(_playerc.player_graphics2d_cmd_polyline_t_points_count_get, _playerc.player_graphics2d_cmd_polyline_t_points_count_set)
    __swig_setmethods__["points"] = _playerc.player_graphics2d_cmd_polyline_t_points_set
    __swig_getmethods__["points"] = _playerc.player_graphics2d_cmd_polyline_t_points_get
    if _newclass:points = property(_playerc.player_graphics2d_cmd_polyline_t_points_get, _playerc.player_graphics2d_cmd_polyline_t_points_set)
    __swig_setmethods__["color"] = _playerc.player_graphics2d_cmd_polyline_t_color_set
    __swig_getmethods__["color"] = _playerc.player_graphics2d_cmd_polyline_t_color_get
    if _newclass:color = property(_playerc.player_graphics2d_cmd_polyline_t_color_get, _playerc.player_graphics2d_cmd_polyline_t_color_set)
    def __init__(self, *args): 
        this = _playerc.new_player_graphics2d_cmd_polyline_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_graphics2d_cmd_polyline_t
    __del__ = lambda self : None;
player_graphics2d_cmd_polyline_t_swigregister = _playerc.player_graphics2d_cmd_polyline_t_swigregister
player_graphics2d_cmd_polyline_t_swigregister(player_graphics2d_cmd_polyline_t)

class player_graphics2d_cmd_polygon_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_graphics2d_cmd_polygon_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_graphics2d_cmd_polygon_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["points_count"] = _playerc.player_graphics2d_cmd_polygon_t_points_count_set
    __swig_getmethods__["points_count"] = _playerc.player_graphics2d_cmd_polygon_t_points_count_get
    if _newclass:points_count = property(_playerc.player_graphics2d_cmd_polygon_t_points_count_get, _playerc.player_graphics2d_cmd_polygon_t_points_count_set)
    __swig_setmethods__["points"] = _playerc.player_graphics2d_cmd_polygon_t_points_set
    __swig_getmethods__["points"] = _playerc.player_graphics2d_cmd_polygon_t_points_get
    if _newclass:points = property(_playerc.player_graphics2d_cmd_polygon_t_points_get, _playerc.player_graphics2d_cmd_polygon_t_points_set)
    __swig_setmethods__["color"] = _playerc.player_graphics2d_cmd_polygon_t_color_set
    __swig_getmethods__["color"] = _playerc.player_graphics2d_cmd_polygon_t_color_get
    if _newclass:color = property(_playerc.player_graphics2d_cmd_polygon_t_color_get, _playerc.player_graphics2d_cmd_polygon_t_color_set)
    __swig_setmethods__["fill_color"] = _playerc.player_graphics2d_cmd_polygon_t_fill_color_set
    __swig_getmethods__["fill_color"] = _playerc.player_graphics2d_cmd_polygon_t_fill_color_get
    if _newclass:fill_color = property(_playerc.player_graphics2d_cmd_polygon_t_fill_color_get, _playerc.player_graphics2d_cmd_polygon_t_fill_color_set)
    __swig_setmethods__["filled"] = _playerc.player_graphics2d_cmd_polygon_t_filled_set
    __swig_getmethods__["filled"] = _playerc.player_graphics2d_cmd_polygon_t_filled_get
    if _newclass:filled = property(_playerc.player_graphics2d_cmd_polygon_t_filled_get, _playerc.player_graphics2d_cmd_polygon_t_filled_set)
    def __init__(self, *args): 
        this = _playerc.new_player_graphics2d_cmd_polygon_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_graphics2d_cmd_polygon_t
    __del__ = lambda self : None;
player_graphics2d_cmd_polygon_t_swigregister = _playerc.player_graphics2d_cmd_polygon_t_swigregister
player_graphics2d_cmd_polygon_t_swigregister(player_graphics2d_cmd_polygon_t)

PLAYER_RFID_CODE = _playerc.PLAYER_RFID_CODE
PLAYER_RFID_STRING = _playerc.PLAYER_RFID_STRING
PLAYER_RFID_DATA_TAGS = _playerc.PLAYER_RFID_DATA_TAGS
PLAYER_RFID_REQ_POWER = _playerc.PLAYER_RFID_REQ_POWER
PLAYER_RFID_REQ_READTAG = _playerc.PLAYER_RFID_REQ_READTAG
PLAYER_RFID_REQ_WRITETAG = _playerc.PLAYER_RFID_REQ_WRITETAG
PLAYER_RFID_REQ_LOCKTAG = _playerc.PLAYER_RFID_REQ_LOCKTAG
class player_rfid_tag_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_rfid_tag_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_rfid_tag_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["type"] = _playerc.player_rfid_tag_t_type_set
    __swig_getmethods__["type"] = _playerc.player_rfid_tag_t_type_get
    if _newclass:type = property(_playerc.player_rfid_tag_t_type_get, _playerc.player_rfid_tag_t_type_set)
    __swig_setmethods__["guid_count"] = _playerc.player_rfid_tag_t_guid_count_set
    __swig_getmethods__["guid_count"] = _playerc.player_rfid_tag_t_guid_count_get
    if _newclass:guid_count = property(_playerc.player_rfid_tag_t_guid_count_get, _playerc.player_rfid_tag_t_guid_count_set)
    __swig_setmethods__["guid"] = _playerc.player_rfid_tag_t_guid_set
    __swig_getmethods__["guid"] = _playerc.player_rfid_tag_t_guid_get
    if _newclass:guid = property(_playerc.player_rfid_tag_t_guid_get, _playerc.player_rfid_tag_t_guid_set)
    def __init__(self, *args): 
        this = _playerc.new_player_rfid_tag_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_rfid_tag_t
    __del__ = lambda self : None;
player_rfid_tag_t_swigregister = _playerc.player_rfid_tag_t_swigregister
player_rfid_tag_t_swigregister(player_rfid_tag_t)

class player_rfid_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_rfid_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_rfid_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["tags_count"] = _playerc.player_rfid_data_t_tags_count_set
    __swig_getmethods__["tags_count"] = _playerc.player_rfid_data_t_tags_count_get
    if _newclass:tags_count = property(_playerc.player_rfid_data_t_tags_count_get, _playerc.player_rfid_data_t_tags_count_set)
    __swig_setmethods__["tags"] = _playerc.player_rfid_data_t_tags_set
    __swig_getmethods__["tags"] = _playerc.player_rfid_data_t_tags_get
    if _newclass:tags = property(_playerc.player_rfid_data_t_tags_get, _playerc.player_rfid_data_t_tags_set)
    def __init__(self, *args): 
        this = _playerc.new_player_rfid_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_rfid_data_t
    __del__ = lambda self : None;
player_rfid_data_t_swigregister = _playerc.player_rfid_data_t_swigregister
player_rfid_data_t_swigregister(player_rfid_data_t)

PLAYER_WSN_CODE = _playerc.PLAYER_WSN_CODE
PLAYER_WSN_STRING = _playerc.PLAYER_WSN_STRING
PLAYER_WSN_DATA_STATE = _playerc.PLAYER_WSN_DATA_STATE
PLAYER_WSN_CMD_DEVSTATE = _playerc.PLAYER_WSN_CMD_DEVSTATE
PLAYER_WSN_REQ_POWER = _playerc.PLAYER_WSN_REQ_POWER
PLAYER_WSN_REQ_DATATYPE = _playerc.PLAYER_WSN_REQ_DATATYPE
PLAYER_WSN_REQ_DATAFREQ = _playerc.PLAYER_WSN_REQ_DATAFREQ
class player_wsn_node_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_wsn_node_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_wsn_node_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["light"] = _playerc.player_wsn_node_data_t_light_set
    __swig_getmethods__["light"] = _playerc.player_wsn_node_data_t_light_get
    if _newclass:light = property(_playerc.player_wsn_node_data_t_light_get, _playerc.player_wsn_node_data_t_light_set)
    __swig_setmethods__["mic"] = _playerc.player_wsn_node_data_t_mic_set
    __swig_getmethods__["mic"] = _playerc.player_wsn_node_data_t_mic_get
    if _newclass:mic = property(_playerc.player_wsn_node_data_t_mic_get, _playerc.player_wsn_node_data_t_mic_set)
    __swig_setmethods__["accel_x"] = _playerc.player_wsn_node_data_t_accel_x_set
    __swig_getmethods__["accel_x"] = _playerc.player_wsn_node_data_t_accel_x_get
    if _newclass:accel_x = property(_playerc.player_wsn_node_data_t_accel_x_get, _playerc.player_wsn_node_data_t_accel_x_set)
    __swig_setmethods__["accel_y"] = _playerc.player_wsn_node_data_t_accel_y_set
    __swig_getmethods__["accel_y"] = _playerc.player_wsn_node_data_t_accel_y_get
    if _newclass:accel_y = property(_playerc.player_wsn_node_data_t_accel_y_get, _playerc.player_wsn_node_data_t_accel_y_set)
    __swig_setmethods__["accel_z"] = _playerc.player_wsn_node_data_t_accel_z_set
    __swig_getmethods__["accel_z"] = _playerc.player_wsn_node_data_t_accel_z_get
    if _newclass:accel_z = property(_playerc.player_wsn_node_data_t_accel_z_get, _playerc.player_wsn_node_data_t_accel_z_set)
    __swig_setmethods__["magn_x"] = _playerc.player_wsn_node_data_t_magn_x_set
    __swig_getmethods__["magn_x"] = _playerc.player_wsn_node_data_t_magn_x_get
    if _newclass:magn_x = property(_playerc.player_wsn_node_data_t_magn_x_get, _playerc.player_wsn_node_data_t_magn_x_set)
    __swig_setmethods__["magn_y"] = _playerc.player_wsn_node_data_t_magn_y_set
    __swig_getmethods__["magn_y"] = _playerc.player_wsn_node_data_t_magn_y_get
    if _newclass:magn_y = property(_playerc.player_wsn_node_data_t_magn_y_get, _playerc.player_wsn_node_data_t_magn_y_set)
    __swig_setmethods__["magn_z"] = _playerc.player_wsn_node_data_t_magn_z_set
    __swig_getmethods__["magn_z"] = _playerc.player_wsn_node_data_t_magn_z_get
    if _newclass:magn_z = property(_playerc.player_wsn_node_data_t_magn_z_get, _playerc.player_wsn_node_data_t_magn_z_set)
    __swig_setmethods__["temperature"] = _playerc.player_wsn_node_data_t_temperature_set
    __swig_getmethods__["temperature"] = _playerc.player_wsn_node_data_t_temperature_get
    if _newclass:temperature = property(_playerc.player_wsn_node_data_t_temperature_get, _playerc.player_wsn_node_data_t_temperature_set)
    __swig_setmethods__["battery"] = _playerc.player_wsn_node_data_t_battery_set
    __swig_getmethods__["battery"] = _playerc.player_wsn_node_data_t_battery_get
    if _newclass:battery = property(_playerc.player_wsn_node_data_t_battery_get, _playerc.player_wsn_node_data_t_battery_set)
    def __init__(self, *args): 
        this = _playerc.new_player_wsn_node_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_wsn_node_data_t
    __del__ = lambda self : None;
player_wsn_node_data_t_swigregister = _playerc.player_wsn_node_data_t_swigregister
player_wsn_node_data_t_swigregister(player_wsn_node_data_t)

class player_wsn_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_wsn_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_wsn_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["node_type"] = _playerc.player_wsn_data_t_node_type_set
    __swig_getmethods__["node_type"] = _playerc.player_wsn_data_t_node_type_get
    if _newclass:node_type = property(_playerc.player_wsn_data_t_node_type_get, _playerc.player_wsn_data_t_node_type_set)
    __swig_setmethods__["node_id"] = _playerc.player_wsn_data_t_node_id_set
    __swig_getmethods__["node_id"] = _playerc.player_wsn_data_t_node_id_get
    if _newclass:node_id = property(_playerc.player_wsn_data_t_node_id_get, _playerc.player_wsn_data_t_node_id_set)
    __swig_setmethods__["node_parent_id"] = _playerc.player_wsn_data_t_node_parent_id_set
    __swig_getmethods__["node_parent_id"] = _playerc.player_wsn_data_t_node_parent_id_get
    if _newclass:node_parent_id = property(_playerc.player_wsn_data_t_node_parent_id_get, _playerc.player_wsn_data_t_node_parent_id_set)
    __swig_setmethods__["data_packet"] = _playerc.player_wsn_data_t_data_packet_set
    __swig_getmethods__["data_packet"] = _playerc.player_wsn_data_t_data_packet_get
    if _newclass:data_packet = property(_playerc.player_wsn_data_t_data_packet_get, _playerc.player_wsn_data_t_data_packet_set)
    def __init__(self, *args): 
        this = _playerc.new_player_wsn_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_wsn_data_t
    __del__ = lambda self : None;
player_wsn_data_t_swigregister = _playerc.player_wsn_data_t_swigregister
player_wsn_data_t_swigregister(player_wsn_data_t)

class player_wsn_cmd_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_wsn_cmd_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_wsn_cmd_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["node_id"] = _playerc.player_wsn_cmd_t_node_id_set
    __swig_getmethods__["node_id"] = _playerc.player_wsn_cmd_t_node_id_get
    if _newclass:node_id = property(_playerc.player_wsn_cmd_t_node_id_get, _playerc.player_wsn_cmd_t_node_id_set)
    __swig_setmethods__["group_id"] = _playerc.player_wsn_cmd_t_group_id_set
    __swig_getmethods__["group_id"] = _playerc.player_wsn_cmd_t_group_id_get
    if _newclass:group_id = property(_playerc.player_wsn_cmd_t_group_id_get, _playerc.player_wsn_cmd_t_group_id_set)
    __swig_setmethods__["device"] = _playerc.player_wsn_cmd_t_device_set
    __swig_getmethods__["device"] = _playerc.player_wsn_cmd_t_device_get
    if _newclass:device = property(_playerc.player_wsn_cmd_t_device_get, _playerc.player_wsn_cmd_t_device_set)
    __swig_setmethods__["enable"] = _playerc.player_wsn_cmd_t_enable_set
    __swig_getmethods__["enable"] = _playerc.player_wsn_cmd_t_enable_get
    if _newclass:enable = property(_playerc.player_wsn_cmd_t_enable_get, _playerc.player_wsn_cmd_t_enable_set)
    def __init__(self, *args): 
        this = _playerc.new_player_wsn_cmd_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_wsn_cmd_t
    __del__ = lambda self : None;
player_wsn_cmd_t_swigregister = _playerc.player_wsn_cmd_t_swigregister
player_wsn_cmd_t_swigregister(player_wsn_cmd_t)

class player_wsn_power_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_wsn_power_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_wsn_power_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["node_id"] = _playerc.player_wsn_power_config_t_node_id_set
    __swig_getmethods__["node_id"] = _playerc.player_wsn_power_config_t_node_id_get
    if _newclass:node_id = property(_playerc.player_wsn_power_config_t_node_id_get, _playerc.player_wsn_power_config_t_node_id_set)
    __swig_setmethods__["group_id"] = _playerc.player_wsn_power_config_t_group_id_set
    __swig_getmethods__["group_id"] = _playerc.player_wsn_power_config_t_group_id_get
    if _newclass:group_id = property(_playerc.player_wsn_power_config_t_group_id_get, _playerc.player_wsn_power_config_t_group_id_set)
    __swig_setmethods__["value"] = _playerc.player_wsn_power_config_t_value_set
    __swig_getmethods__["value"] = _playerc.player_wsn_power_config_t_value_get
    if _newclass:value = property(_playerc.player_wsn_power_config_t_value_get, _playerc.player_wsn_power_config_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_wsn_power_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_wsn_power_config_t
    __del__ = lambda self : None;
player_wsn_power_config_t_swigregister = _playerc.player_wsn_power_config_t_swigregister
player_wsn_power_config_t_swigregister(player_wsn_power_config_t)

class player_wsn_datatype_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_wsn_datatype_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_wsn_datatype_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_wsn_datatype_config_t_value_set
    __swig_getmethods__["value"] = _playerc.player_wsn_datatype_config_t_value_get
    if _newclass:value = property(_playerc.player_wsn_datatype_config_t_value_get, _playerc.player_wsn_datatype_config_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_wsn_datatype_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_wsn_datatype_config_t
    __del__ = lambda self : None;
player_wsn_datatype_config_t_swigregister = _playerc.player_wsn_datatype_config_t_swigregister
player_wsn_datatype_config_t_swigregister(player_wsn_datatype_config_t)

class player_wsn_datafreq_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_wsn_datafreq_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_wsn_datafreq_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["node_id"] = _playerc.player_wsn_datafreq_config_t_node_id_set
    __swig_getmethods__["node_id"] = _playerc.player_wsn_datafreq_config_t_node_id_get
    if _newclass:node_id = property(_playerc.player_wsn_datafreq_config_t_node_id_get, _playerc.player_wsn_datafreq_config_t_node_id_set)
    __swig_setmethods__["group_id"] = _playerc.player_wsn_datafreq_config_t_group_id_set
    __swig_getmethods__["group_id"] = _playerc.player_wsn_datafreq_config_t_group_id_get
    if _newclass:group_id = property(_playerc.player_wsn_datafreq_config_t_group_id_get, _playerc.player_wsn_datafreq_config_t_group_id_set)
    __swig_setmethods__["frequency"] = _playerc.player_wsn_datafreq_config_t_frequency_set
    __swig_getmethods__["frequency"] = _playerc.player_wsn_datafreq_config_t_frequency_get
    if _newclass:frequency = property(_playerc.player_wsn_datafreq_config_t_frequency_get, _playerc.player_wsn_datafreq_config_t_frequency_set)
    def __init__(self, *args): 
        this = _playerc.new_player_wsn_datafreq_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_wsn_datafreq_config_t
    __del__ = lambda self : None;
player_wsn_datafreq_config_t_swigregister = _playerc.player_wsn_datafreq_config_t_swigregister
player_wsn_datafreq_config_t_swigregister(player_wsn_datafreq_config_t)

PLAYER_GRAPHICS3D_CODE = _playerc.PLAYER_GRAPHICS3D_CODE
PLAYER_GRAPHICS3D_STRING = _playerc.PLAYER_GRAPHICS3D_STRING
PLAYER_GRAPHICS3D_CMD_CLEAR = _playerc.PLAYER_GRAPHICS3D_CMD_CLEAR
PLAYER_GRAPHICS3D_CMD_DRAW = _playerc.PLAYER_GRAPHICS3D_CMD_DRAW
PLAYER_GRAPHICS3D_CMD_TRANSLATE = _playerc.PLAYER_GRAPHICS3D_CMD_TRANSLATE
PLAYER_GRAPHICS3D_CMD_ROTATE = _playerc.PLAYER_GRAPHICS3D_CMD_ROTATE
PLAYER_GRAPHICS3D_CMD_PUSH = _playerc.PLAYER_GRAPHICS3D_CMD_PUSH
PLAYER_GRAPHICS3D_CMD_POP = _playerc.PLAYER_GRAPHICS3D_CMD_POP
PLAYER_DRAW_POINTS = _playerc.PLAYER_DRAW_POINTS
PLAYER_DRAW_LINES = _playerc.PLAYER_DRAW_LINES
PLAYER_DRAW_LINE_STRIP = _playerc.PLAYER_DRAW_LINE_STRIP
PLAYER_DRAW_LINE_LOOP = _playerc.PLAYER_DRAW_LINE_LOOP
PLAYER_DRAW_TRIANGLES = _playerc.PLAYER_DRAW_TRIANGLES
PLAYER_DRAW_TRIANGLE_STRIP = _playerc.PLAYER_DRAW_TRIANGLE_STRIP
PLAYER_DRAW_TRIANGLE_FAN = _playerc.PLAYER_DRAW_TRIANGLE_FAN
PLAYER_DRAW_QUADS = _playerc.PLAYER_DRAW_QUADS
PLAYER_DRAW_QUAD_STRIP = _playerc.PLAYER_DRAW_QUAD_STRIP
PLAYER_DRAW_POLYGON = _playerc.PLAYER_DRAW_POLYGON
class player_graphics3d_cmd_draw_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_graphics3d_cmd_draw_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_graphics3d_cmd_draw_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["draw_mode"] = _playerc.player_graphics3d_cmd_draw_t_draw_mode_set
    __swig_getmethods__["draw_mode"] = _playerc.player_graphics3d_cmd_draw_t_draw_mode_get
    if _newclass:draw_mode = property(_playerc.player_graphics3d_cmd_draw_t_draw_mode_get, _playerc.player_graphics3d_cmd_draw_t_draw_mode_set)
    __swig_setmethods__["points_count"] = _playerc.player_graphics3d_cmd_draw_t_points_count_set
    __swig_getmethods__["points_count"] = _playerc.player_graphics3d_cmd_draw_t_points_count_get
    if _newclass:points_count = property(_playerc.player_graphics3d_cmd_draw_t_points_count_get, _playerc.player_graphics3d_cmd_draw_t_points_count_set)
    __swig_setmethods__["points"] = _playerc.player_graphics3d_cmd_draw_t_points_set
    __swig_getmethods__["points"] = _playerc.player_graphics3d_cmd_draw_t_points_get
    if _newclass:points = property(_playerc.player_graphics3d_cmd_draw_t_points_get, _playerc.player_graphics3d_cmd_draw_t_points_set)
    __swig_setmethods__["color"] = _playerc.player_graphics3d_cmd_draw_t_color_set
    __swig_getmethods__["color"] = _playerc.player_graphics3d_cmd_draw_t_color_get
    if _newclass:color = property(_playerc.player_graphics3d_cmd_draw_t_color_get, _playerc.player_graphics3d_cmd_draw_t_color_set)
    def __init__(self, *args): 
        this = _playerc.new_player_graphics3d_cmd_draw_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_graphics3d_cmd_draw_t
    __del__ = lambda self : None;
player_graphics3d_cmd_draw_t_swigregister = _playerc.player_graphics3d_cmd_draw_t_swigregister
player_graphics3d_cmd_draw_t_swigregister(player_graphics3d_cmd_draw_t)

class player_graphics3d_cmd_translate_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_graphics3d_cmd_translate_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_graphics3d_cmd_translate_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["x"] = _playerc.player_graphics3d_cmd_translate_t_x_set
    __swig_getmethods__["x"] = _playerc.player_graphics3d_cmd_translate_t_x_get
    if _newclass:x = property(_playerc.player_graphics3d_cmd_translate_t_x_get, _playerc.player_graphics3d_cmd_translate_t_x_set)
    __swig_setmethods__["y"] = _playerc.player_graphics3d_cmd_translate_t_y_set
    __swig_getmethods__["y"] = _playerc.player_graphics3d_cmd_translate_t_y_get
    if _newclass:y = property(_playerc.player_graphics3d_cmd_translate_t_y_get, _playerc.player_graphics3d_cmd_translate_t_y_set)
    __swig_setmethods__["z"] = _playerc.player_graphics3d_cmd_translate_t_z_set
    __swig_getmethods__["z"] = _playerc.player_graphics3d_cmd_translate_t_z_get
    if _newclass:z = property(_playerc.player_graphics3d_cmd_translate_t_z_get, _playerc.player_graphics3d_cmd_translate_t_z_set)
    def __init__(self, *args): 
        this = _playerc.new_player_graphics3d_cmd_translate_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_graphics3d_cmd_translate_t
    __del__ = lambda self : None;
player_graphics3d_cmd_translate_t_swigregister = _playerc.player_graphics3d_cmd_translate_t_swigregister
player_graphics3d_cmd_translate_t_swigregister(player_graphics3d_cmd_translate_t)

class player_graphics3d_cmd_rotate_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_graphics3d_cmd_rotate_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_graphics3d_cmd_rotate_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["a"] = _playerc.player_graphics3d_cmd_rotate_t_a_set
    __swig_getmethods__["a"] = _playerc.player_graphics3d_cmd_rotate_t_a_get
    if _newclass:a = property(_playerc.player_graphics3d_cmd_rotate_t_a_get, _playerc.player_graphics3d_cmd_rotate_t_a_set)
    __swig_setmethods__["x"] = _playerc.player_graphics3d_cmd_rotate_t_x_set
    __swig_getmethods__["x"] = _playerc.player_graphics3d_cmd_rotate_t_x_get
    if _newclass:x = property(_playerc.player_graphics3d_cmd_rotate_t_x_get, _playerc.player_graphics3d_cmd_rotate_t_x_set)
    __swig_setmethods__["y"] = _playerc.player_graphics3d_cmd_rotate_t_y_set
    __swig_getmethods__["y"] = _playerc.player_graphics3d_cmd_rotate_t_y_get
    if _newclass:y = property(_playerc.player_graphics3d_cmd_rotate_t_y_get, _playerc.player_graphics3d_cmd_rotate_t_y_set)
    __swig_setmethods__["z"] = _playerc.player_graphics3d_cmd_rotate_t_z_set
    __swig_getmethods__["z"] = _playerc.player_graphics3d_cmd_rotate_t_z_get
    if _newclass:z = property(_playerc.player_graphics3d_cmd_rotate_t_z_get, _playerc.player_graphics3d_cmd_rotate_t_z_set)
    def __init__(self, *args): 
        this = _playerc.new_player_graphics3d_cmd_rotate_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_graphics3d_cmd_rotate_t
    __del__ = lambda self : None;
player_graphics3d_cmd_rotate_t_swigregister = _playerc.player_graphics3d_cmd_rotate_t_swigregister
player_graphics3d_cmd_rotate_t_swigregister(player_graphics3d_cmd_rotate_t)

PLAYER_HEALTH_CODE = _playerc.PLAYER_HEALTH_CODE
PLAYER_HEALTH_STRING = _playerc.PLAYER_HEALTH_STRING
PLAYER_HEALTH_DATA_STATE = _playerc.PLAYER_HEALTH_DATA_STATE
class player_health_cpu_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_health_cpu_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_health_cpu_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["idle"] = _playerc.player_health_cpu_t_idle_set
    __swig_getmethods__["idle"] = _playerc.player_health_cpu_t_idle_get
    if _newclass:idle = property(_playerc.player_health_cpu_t_idle_get, _playerc.player_health_cpu_t_idle_set)
    __swig_setmethods__["system"] = _playerc.player_health_cpu_t_system_set
    __swig_getmethods__["system"] = _playerc.player_health_cpu_t_system_get
    if _newclass:system = property(_playerc.player_health_cpu_t_system_get, _playerc.player_health_cpu_t_system_set)
    __swig_setmethods__["user"] = _playerc.player_health_cpu_t_user_set
    __swig_getmethods__["user"] = _playerc.player_health_cpu_t_user_get
    if _newclass:user = property(_playerc.player_health_cpu_t_user_get, _playerc.player_health_cpu_t_user_set)
    def __init__(self, *args): 
        this = _playerc.new_player_health_cpu_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_health_cpu_t
    __del__ = lambda self : None;
player_health_cpu_t_swigregister = _playerc.player_health_cpu_t_swigregister
player_health_cpu_t_swigregister(player_health_cpu_t)

class player_health_memory_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_health_memory_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_health_memory_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["total"] = _playerc.player_health_memory_t_total_set
    __swig_getmethods__["total"] = _playerc.player_health_memory_t_total_get
    if _newclass:total = property(_playerc.player_health_memory_t_total_get, _playerc.player_health_memory_t_total_set)
    __swig_setmethods__["used"] = _playerc.player_health_memory_t_used_set
    __swig_getmethods__["used"] = _playerc.player_health_memory_t_used_get
    if _newclass:used = property(_playerc.player_health_memory_t_used_get, _playerc.player_health_memory_t_used_set)
    __swig_setmethods__["free"] = _playerc.player_health_memory_t_free_set
    __swig_getmethods__["free"] = _playerc.player_health_memory_t_free_get
    if _newclass:free = property(_playerc.player_health_memory_t_free_get, _playerc.player_health_memory_t_free_set)
    def __init__(self, *args): 
        this = _playerc.new_player_health_memory_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_health_memory_t
    __del__ = lambda self : None;
player_health_memory_t_swigregister = _playerc.player_health_memory_t_swigregister
player_health_memory_t_swigregister(player_health_memory_t)

class player_health_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_health_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_health_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["cpu_usage"] = _playerc.player_health_data_t_cpu_usage_set
    __swig_getmethods__["cpu_usage"] = _playerc.player_health_data_t_cpu_usage_get
    if _newclass:cpu_usage = property(_playerc.player_health_data_t_cpu_usage_get, _playerc.player_health_data_t_cpu_usage_set)
    __swig_setmethods__["mem"] = _playerc.player_health_data_t_mem_set
    __swig_getmethods__["mem"] = _playerc.player_health_data_t_mem_get
    if _newclass:mem = property(_playerc.player_health_data_t_mem_get, _playerc.player_health_data_t_mem_set)
    __swig_setmethods__["swap"] = _playerc.player_health_data_t_swap_set
    __swig_getmethods__["swap"] = _playerc.player_health_data_t_swap_get
    if _newclass:swap = property(_playerc.player_health_data_t_swap_get, _playerc.player_health_data_t_swap_set)
    def __init__(self, *args): 
        this = _playerc.new_player_health_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_health_data_t
    __del__ = lambda self : None;
player_health_data_t_swigregister = _playerc.player_health_data_t_swigregister
player_health_data_t_swigregister(player_health_data_t)

PLAYER_IMU_CODE = _playerc.PLAYER_IMU_CODE
PLAYER_IMU_STRING = _playerc.PLAYER_IMU_STRING
PLAYER_IMU_DATA_STATE = _playerc.PLAYER_IMU_DATA_STATE
PLAYER_IMU_DATA_CALIB = _playerc.PLAYER_IMU_DATA_CALIB
PLAYER_IMU_DATA_QUAT = _playerc.PLAYER_IMU_DATA_QUAT
PLAYER_IMU_DATA_EULER = _playerc.PLAYER_IMU_DATA_EULER
PLAYER_IMU_DATA_FULLSTATE = _playerc.PLAYER_IMU_DATA_FULLSTATE
PLAYER_IMU_REQ_SET_DATATYPE = _playerc.PLAYER_IMU_REQ_SET_DATATYPE
PLAYER_IMU_REQ_RESET_ORIENTATION = _playerc.PLAYER_IMU_REQ_RESET_ORIENTATION
class player_imu_data_state_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_imu_data_state_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_imu_data_state_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_imu_data_state_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_imu_data_state_t_pose_get
    if _newclass:pose = property(_playerc.player_imu_data_state_t_pose_get, _playerc.player_imu_data_state_t_pose_set)
    def __init__(self, *args): 
        this = _playerc.new_player_imu_data_state_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_imu_data_state_t
    __del__ = lambda self : None;
player_imu_data_state_t_swigregister = _playerc.player_imu_data_state_t_swigregister
player_imu_data_state_t_swigregister(player_imu_data_state_t)

class player_imu_data_calib_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_imu_data_calib_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_imu_data_calib_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["accel_x"] = _playerc.player_imu_data_calib_t_accel_x_set
    __swig_getmethods__["accel_x"] = _playerc.player_imu_data_calib_t_accel_x_get
    if _newclass:accel_x = property(_playerc.player_imu_data_calib_t_accel_x_get, _playerc.player_imu_data_calib_t_accel_x_set)
    __swig_setmethods__["accel_y"] = _playerc.player_imu_data_calib_t_accel_y_set
    __swig_getmethods__["accel_y"] = _playerc.player_imu_data_calib_t_accel_y_get
    if _newclass:accel_y = property(_playerc.player_imu_data_calib_t_accel_y_get, _playerc.player_imu_data_calib_t_accel_y_set)
    __swig_setmethods__["accel_z"] = _playerc.player_imu_data_calib_t_accel_z_set
    __swig_getmethods__["accel_z"] = _playerc.player_imu_data_calib_t_accel_z_get
    if _newclass:accel_z = property(_playerc.player_imu_data_calib_t_accel_z_get, _playerc.player_imu_data_calib_t_accel_z_set)
    __swig_setmethods__["gyro_x"] = _playerc.player_imu_data_calib_t_gyro_x_set
    __swig_getmethods__["gyro_x"] = _playerc.player_imu_data_calib_t_gyro_x_get
    if _newclass:gyro_x = property(_playerc.player_imu_data_calib_t_gyro_x_get, _playerc.player_imu_data_calib_t_gyro_x_set)
    __swig_setmethods__["gyro_y"] = _playerc.player_imu_data_calib_t_gyro_y_set
    __swig_getmethods__["gyro_y"] = _playerc.player_imu_data_calib_t_gyro_y_get
    if _newclass:gyro_y = property(_playerc.player_imu_data_calib_t_gyro_y_get, _playerc.player_imu_data_calib_t_gyro_y_set)
    __swig_setmethods__["gyro_z"] = _playerc.player_imu_data_calib_t_gyro_z_set
    __swig_getmethods__["gyro_z"] = _playerc.player_imu_data_calib_t_gyro_z_get
    if _newclass:gyro_z = property(_playerc.player_imu_data_calib_t_gyro_z_get, _playerc.player_imu_data_calib_t_gyro_z_set)
    __swig_setmethods__["magn_x"] = _playerc.player_imu_data_calib_t_magn_x_set
    __swig_getmethods__["magn_x"] = _playerc.player_imu_data_calib_t_magn_x_get
    if _newclass:magn_x = property(_playerc.player_imu_data_calib_t_magn_x_get, _playerc.player_imu_data_calib_t_magn_x_set)
    __swig_setmethods__["magn_y"] = _playerc.player_imu_data_calib_t_magn_y_set
    __swig_getmethods__["magn_y"] = _playerc.player_imu_data_calib_t_magn_y_get
    if _newclass:magn_y = property(_playerc.player_imu_data_calib_t_magn_y_get, _playerc.player_imu_data_calib_t_magn_y_set)
    __swig_setmethods__["magn_z"] = _playerc.player_imu_data_calib_t_magn_z_set
    __swig_getmethods__["magn_z"] = _playerc.player_imu_data_calib_t_magn_z_get
    if _newclass:magn_z = property(_playerc.player_imu_data_calib_t_magn_z_get, _playerc.player_imu_data_calib_t_magn_z_set)
    def __init__(self, *args): 
        this = _playerc.new_player_imu_data_calib_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_imu_data_calib_t
    __del__ = lambda self : None;
player_imu_data_calib_t_swigregister = _playerc.player_imu_data_calib_t_swigregister
player_imu_data_calib_t_swigregister(player_imu_data_calib_t)

class player_imu_data_quat_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_imu_data_quat_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_imu_data_quat_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["calib_data"] = _playerc.player_imu_data_quat_t_calib_data_set
    __swig_getmethods__["calib_data"] = _playerc.player_imu_data_quat_t_calib_data_get
    if _newclass:calib_data = property(_playerc.player_imu_data_quat_t_calib_data_get, _playerc.player_imu_data_quat_t_calib_data_set)
    __swig_setmethods__["q0"] = _playerc.player_imu_data_quat_t_q0_set
    __swig_getmethods__["q0"] = _playerc.player_imu_data_quat_t_q0_get
    if _newclass:q0 = property(_playerc.player_imu_data_quat_t_q0_get, _playerc.player_imu_data_quat_t_q0_set)
    __swig_setmethods__["q1"] = _playerc.player_imu_data_quat_t_q1_set
    __swig_getmethods__["q1"] = _playerc.player_imu_data_quat_t_q1_get
    if _newclass:q1 = property(_playerc.player_imu_data_quat_t_q1_get, _playerc.player_imu_data_quat_t_q1_set)
    __swig_setmethods__["q2"] = _playerc.player_imu_data_quat_t_q2_set
    __swig_getmethods__["q2"] = _playerc.player_imu_data_quat_t_q2_get
    if _newclass:q2 = property(_playerc.player_imu_data_quat_t_q2_get, _playerc.player_imu_data_quat_t_q2_set)
    __swig_setmethods__["q3"] = _playerc.player_imu_data_quat_t_q3_set
    __swig_getmethods__["q3"] = _playerc.player_imu_data_quat_t_q3_get
    if _newclass:q3 = property(_playerc.player_imu_data_quat_t_q3_get, _playerc.player_imu_data_quat_t_q3_set)
    def __init__(self, *args): 
        this = _playerc.new_player_imu_data_quat_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_imu_data_quat_t
    __del__ = lambda self : None;
player_imu_data_quat_t_swigregister = _playerc.player_imu_data_quat_t_swigregister
player_imu_data_quat_t_swigregister(player_imu_data_quat_t)

class player_imu_data_euler_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_imu_data_euler_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_imu_data_euler_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["calib_data"] = _playerc.player_imu_data_euler_t_calib_data_set
    __swig_getmethods__["calib_data"] = _playerc.player_imu_data_euler_t_calib_data_get
    if _newclass:calib_data = property(_playerc.player_imu_data_euler_t_calib_data_get, _playerc.player_imu_data_euler_t_calib_data_set)
    __swig_setmethods__["orientation"] = _playerc.player_imu_data_euler_t_orientation_set
    __swig_getmethods__["orientation"] = _playerc.player_imu_data_euler_t_orientation_get
    if _newclass:orientation = property(_playerc.player_imu_data_euler_t_orientation_get, _playerc.player_imu_data_euler_t_orientation_set)
    def __init__(self, *args): 
        this = _playerc.new_player_imu_data_euler_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_imu_data_euler_t
    __del__ = lambda self : None;
player_imu_data_euler_t_swigregister = _playerc.player_imu_data_euler_t_swigregister
player_imu_data_euler_t_swigregister(player_imu_data_euler_t)

class player_imu_data_fullstate_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_imu_data_fullstate_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_imu_data_fullstate_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_imu_data_fullstate_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_imu_data_fullstate_t_pose_get
    if _newclass:pose = property(_playerc.player_imu_data_fullstate_t_pose_get, _playerc.player_imu_data_fullstate_t_pose_set)
    __swig_setmethods__["vel"] = _playerc.player_imu_data_fullstate_t_vel_set
    __swig_getmethods__["vel"] = _playerc.player_imu_data_fullstate_t_vel_get
    if _newclass:vel = property(_playerc.player_imu_data_fullstate_t_vel_get, _playerc.player_imu_data_fullstate_t_vel_set)
    __swig_setmethods__["acc"] = _playerc.player_imu_data_fullstate_t_acc_set
    __swig_getmethods__["acc"] = _playerc.player_imu_data_fullstate_t_acc_get
    if _newclass:acc = property(_playerc.player_imu_data_fullstate_t_acc_get, _playerc.player_imu_data_fullstate_t_acc_set)
    def __init__(self, *args): 
        this = _playerc.new_player_imu_data_fullstate_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_imu_data_fullstate_t
    __del__ = lambda self : None;
player_imu_data_fullstate_t_swigregister = _playerc.player_imu_data_fullstate_t_swigregister
player_imu_data_fullstate_t_swigregister(player_imu_data_fullstate_t)

class player_imu_datatype_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_imu_datatype_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_imu_datatype_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_imu_datatype_config_t_value_set
    __swig_getmethods__["value"] = _playerc.player_imu_datatype_config_t_value_get
    if _newclass:value = property(_playerc.player_imu_datatype_config_t_value_get, _playerc.player_imu_datatype_config_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_imu_datatype_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_imu_datatype_config_t
    __del__ = lambda self : None;
player_imu_datatype_config_t_swigregister = _playerc.player_imu_datatype_config_t_swigregister
player_imu_datatype_config_t_swigregister(player_imu_datatype_config_t)

class player_imu_reset_orientation_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_imu_reset_orientation_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_imu_reset_orientation_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["value"] = _playerc.player_imu_reset_orientation_config_t_value_set
    __swig_getmethods__["value"] = _playerc.player_imu_reset_orientation_config_t_value_get
    if _newclass:value = property(_playerc.player_imu_reset_orientation_config_t_value_get, _playerc.player_imu_reset_orientation_config_t_value_set)
    def __init__(self, *args): 
        this = _playerc.new_player_imu_reset_orientation_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_imu_reset_orientation_config_t
    __del__ = lambda self : None;
player_imu_reset_orientation_config_t_swigregister = _playerc.player_imu_reset_orientation_config_t_swigregister
player_imu_reset_orientation_config_t_swigregister(player_imu_reset_orientation_config_t)

PLAYER_POINTCLOUD3D_CODE = _playerc.PLAYER_POINTCLOUD3D_CODE
PLAYER_POINTCLOUD3D_STRING = _playerc.PLAYER_POINTCLOUD3D_STRING
PLAYER_POINTCLOUD3D_DATA_STATE = _playerc.PLAYER_POINTCLOUD3D_DATA_STATE
class player_pointcloud3d_element_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_pointcloud3d_element_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_pointcloud3d_element_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["point"] = _playerc.player_pointcloud3d_element_t_point_set
    __swig_getmethods__["point"] = _playerc.player_pointcloud3d_element_t_point_get
    if _newclass:point = property(_playerc.player_pointcloud3d_element_t_point_get, _playerc.player_pointcloud3d_element_t_point_set)
    __swig_setmethods__["color"] = _playerc.player_pointcloud3d_element_t_color_set
    __swig_getmethods__["color"] = _playerc.player_pointcloud3d_element_t_color_get
    if _newclass:color = property(_playerc.player_pointcloud3d_element_t_color_get, _playerc.player_pointcloud3d_element_t_color_set)
    def __init__(self, *args): 
        this = _playerc.new_player_pointcloud3d_element_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_pointcloud3d_element_t
    __del__ = lambda self : None;
player_pointcloud3d_element_t_swigregister = _playerc.player_pointcloud3d_element_t_swigregister
player_pointcloud3d_element_t_swigregister(player_pointcloud3d_element_t)

class player_pointcloud3d_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_pointcloud3d_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_pointcloud3d_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["points_count"] = _playerc.player_pointcloud3d_data_t_points_count_set
    __swig_getmethods__["points_count"] = _playerc.player_pointcloud3d_data_t_points_count_get
    if _newclass:points_count = property(_playerc.player_pointcloud3d_data_t_points_count_get, _playerc.player_pointcloud3d_data_t_points_count_set)
    __swig_setmethods__["points"] = _playerc.player_pointcloud3d_data_t_points_set
    __swig_getmethods__["points"] = _playerc.player_pointcloud3d_data_t_points_get
    if _newclass:points = property(_playerc.player_pointcloud3d_data_t_points_get, _playerc.player_pointcloud3d_data_t_points_set)
    def __init__(self, *args): 
        this = _playerc.new_player_pointcloud3d_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_pointcloud3d_data_t
    __del__ = lambda self : None;
player_pointcloud3d_data_t_swigregister = _playerc.player_pointcloud3d_data_t_swigregister
player_pointcloud3d_data_t_swigregister(player_pointcloud3d_data_t)

PLAYER_RANGER_CODE = _playerc.PLAYER_RANGER_CODE
PLAYER_RANGER_STRING = _playerc.PLAYER_RANGER_STRING
PLAYER_RANGER_DATA_RANGE = _playerc.PLAYER_RANGER_DATA_RANGE
PLAYER_RANGER_DATA_RANGESTAMPED = _playerc.PLAYER_RANGER_DATA_RANGESTAMPED
PLAYER_RANGER_DATA_INTNS = _playerc.PLAYER_RANGER_DATA_INTNS
PLAYER_RANGER_DATA_INTNSSTAMPED = _playerc.PLAYER_RANGER_DATA_INTNSSTAMPED
PLAYER_RANGER_DATA_GEOM = _playerc.PLAYER_RANGER_DATA_GEOM
PLAYER_RANGER_REQ_GET_GEOM = _playerc.PLAYER_RANGER_REQ_GET_GEOM
PLAYER_RANGER_REQ_POWER = _playerc.PLAYER_RANGER_REQ_POWER
PLAYER_RANGER_REQ_INTNS = _playerc.PLAYER_RANGER_REQ_INTNS
PLAYER_RANGER_REQ_SET_CONFIG = _playerc.PLAYER_RANGER_REQ_SET_CONFIG
PLAYER_RANGER_REQ_GET_CONFIG = _playerc.PLAYER_RANGER_REQ_GET_CONFIG
class player_ranger_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ranger_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ranger_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["min_angle"] = _playerc.player_ranger_config_t_min_angle_set
    __swig_getmethods__["min_angle"] = _playerc.player_ranger_config_t_min_angle_get
    if _newclass:min_angle = property(_playerc.player_ranger_config_t_min_angle_get, _playerc.player_ranger_config_t_min_angle_set)
    __swig_setmethods__["max_angle"] = _playerc.player_ranger_config_t_max_angle_set
    __swig_getmethods__["max_angle"] = _playerc.player_ranger_config_t_max_angle_get
    if _newclass:max_angle = property(_playerc.player_ranger_config_t_max_angle_get, _playerc.player_ranger_config_t_max_angle_set)
    __swig_setmethods__["angular_res"] = _playerc.player_ranger_config_t_angular_res_set
    __swig_getmethods__["angular_res"] = _playerc.player_ranger_config_t_angular_res_get
    if _newclass:angular_res = property(_playerc.player_ranger_config_t_angular_res_get, _playerc.player_ranger_config_t_angular_res_set)
    __swig_setmethods__["min_range"] = _playerc.player_ranger_config_t_min_range_set
    __swig_getmethods__["min_range"] = _playerc.player_ranger_config_t_min_range_get
    if _newclass:min_range = property(_playerc.player_ranger_config_t_min_range_get, _playerc.player_ranger_config_t_min_range_set)
    __swig_setmethods__["max_range"] = _playerc.player_ranger_config_t_max_range_set
    __swig_getmethods__["max_range"] = _playerc.player_ranger_config_t_max_range_get
    if _newclass:max_range = property(_playerc.player_ranger_config_t_max_range_get, _playerc.player_ranger_config_t_max_range_set)
    __swig_setmethods__["range_res"] = _playerc.player_ranger_config_t_range_res_set
    __swig_getmethods__["range_res"] = _playerc.player_ranger_config_t_range_res_get
    if _newclass:range_res = property(_playerc.player_ranger_config_t_range_res_get, _playerc.player_ranger_config_t_range_res_set)
    __swig_setmethods__["frequency"] = _playerc.player_ranger_config_t_frequency_set
    __swig_getmethods__["frequency"] = _playerc.player_ranger_config_t_frequency_get
    if _newclass:frequency = property(_playerc.player_ranger_config_t_frequency_get, _playerc.player_ranger_config_t_frequency_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ranger_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ranger_config_t
    __del__ = lambda self : None;
player_ranger_config_t_swigregister = _playerc.player_ranger_config_t_swigregister
player_ranger_config_t_swigregister(player_ranger_config_t)

class player_ranger_geom_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ranger_geom_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ranger_geom_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.player_ranger_geom_t_pose_set
    __swig_getmethods__["pose"] = _playerc.player_ranger_geom_t_pose_get
    if _newclass:pose = property(_playerc.player_ranger_geom_t_pose_get, _playerc.player_ranger_geom_t_pose_set)
    __swig_setmethods__["size"] = _playerc.player_ranger_geom_t_size_set
    __swig_getmethods__["size"] = _playerc.player_ranger_geom_t_size_get
    if _newclass:size = property(_playerc.player_ranger_geom_t_size_get, _playerc.player_ranger_geom_t_size_set)
    __swig_setmethods__["element_poses_count"] = _playerc.player_ranger_geom_t_element_poses_count_set
    __swig_getmethods__["element_poses_count"] = _playerc.player_ranger_geom_t_element_poses_count_get
    if _newclass:element_poses_count = property(_playerc.player_ranger_geom_t_element_poses_count_get, _playerc.player_ranger_geom_t_element_poses_count_set)
    __swig_setmethods__["element_poses"] = _playerc.player_ranger_geom_t_element_poses_set
    __swig_getmethods__["element_poses"] = _playerc.player_ranger_geom_t_element_poses_get
    if _newclass:element_poses = property(_playerc.player_ranger_geom_t_element_poses_get, _playerc.player_ranger_geom_t_element_poses_set)
    __swig_setmethods__["element_sizes_count"] = _playerc.player_ranger_geom_t_element_sizes_count_set
    __swig_getmethods__["element_sizes_count"] = _playerc.player_ranger_geom_t_element_sizes_count_get
    if _newclass:element_sizes_count = property(_playerc.player_ranger_geom_t_element_sizes_count_get, _playerc.player_ranger_geom_t_element_sizes_count_set)
    __swig_setmethods__["element_sizes"] = _playerc.player_ranger_geom_t_element_sizes_set
    __swig_getmethods__["element_sizes"] = _playerc.player_ranger_geom_t_element_sizes_get
    if _newclass:element_sizes = property(_playerc.player_ranger_geom_t_element_sizes_get, _playerc.player_ranger_geom_t_element_sizes_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ranger_geom_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ranger_geom_t
    __del__ = lambda self : None;
player_ranger_geom_t_swigregister = _playerc.player_ranger_geom_t_swigregister
player_ranger_geom_t_swigregister(player_ranger_geom_t)

class player_ranger_data_range_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ranger_data_range_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ranger_data_range_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["ranges_count"] = _playerc.player_ranger_data_range_t_ranges_count_set
    __swig_getmethods__["ranges_count"] = _playerc.player_ranger_data_range_t_ranges_count_get
    if _newclass:ranges_count = property(_playerc.player_ranger_data_range_t_ranges_count_get, _playerc.player_ranger_data_range_t_ranges_count_set)
    __swig_setmethods__["ranges"] = _playerc.player_ranger_data_range_t_ranges_set
    __swig_getmethods__["ranges"] = _playerc.player_ranger_data_range_t_ranges_get
    if _newclass:ranges = property(_playerc.player_ranger_data_range_t_ranges_get, _playerc.player_ranger_data_range_t_ranges_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ranger_data_range_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ranger_data_range_t
    __del__ = lambda self : None;
player_ranger_data_range_t_swigregister = _playerc.player_ranger_data_range_t_swigregister
player_ranger_data_range_t_swigregister(player_ranger_data_range_t)

class player_ranger_data_rangestamped_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ranger_data_rangestamped_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ranger_data_rangestamped_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["data"] = _playerc.player_ranger_data_rangestamped_t_data_set
    __swig_getmethods__["data"] = _playerc.player_ranger_data_rangestamped_t_data_get
    if _newclass:data = property(_playerc.player_ranger_data_rangestamped_t_data_get, _playerc.player_ranger_data_rangestamped_t_data_set)
    __swig_setmethods__["have_geom"] = _playerc.player_ranger_data_rangestamped_t_have_geom_set
    __swig_getmethods__["have_geom"] = _playerc.player_ranger_data_rangestamped_t_have_geom_get
    if _newclass:have_geom = property(_playerc.player_ranger_data_rangestamped_t_have_geom_get, _playerc.player_ranger_data_rangestamped_t_have_geom_set)
    __swig_setmethods__["geom"] = _playerc.player_ranger_data_rangestamped_t_geom_set
    __swig_getmethods__["geom"] = _playerc.player_ranger_data_rangestamped_t_geom_get
    if _newclass:geom = property(_playerc.player_ranger_data_rangestamped_t_geom_get, _playerc.player_ranger_data_rangestamped_t_geom_set)
    __swig_setmethods__["have_config"] = _playerc.player_ranger_data_rangestamped_t_have_config_set
    __swig_getmethods__["have_config"] = _playerc.player_ranger_data_rangestamped_t_have_config_get
    if _newclass:have_config = property(_playerc.player_ranger_data_rangestamped_t_have_config_get, _playerc.player_ranger_data_rangestamped_t_have_config_set)
    __swig_setmethods__["config"] = _playerc.player_ranger_data_rangestamped_t_config_set
    __swig_getmethods__["config"] = _playerc.player_ranger_data_rangestamped_t_config_get
    if _newclass:config = property(_playerc.player_ranger_data_rangestamped_t_config_get, _playerc.player_ranger_data_rangestamped_t_config_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ranger_data_rangestamped_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ranger_data_rangestamped_t
    __del__ = lambda self : None;
player_ranger_data_rangestamped_t_swigregister = _playerc.player_ranger_data_rangestamped_t_swigregister
player_ranger_data_rangestamped_t_swigregister(player_ranger_data_rangestamped_t)

class player_ranger_data_intns_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ranger_data_intns_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ranger_data_intns_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["intensities_count"] = _playerc.player_ranger_data_intns_t_intensities_count_set
    __swig_getmethods__["intensities_count"] = _playerc.player_ranger_data_intns_t_intensities_count_get
    if _newclass:intensities_count = property(_playerc.player_ranger_data_intns_t_intensities_count_get, _playerc.player_ranger_data_intns_t_intensities_count_set)
    __swig_setmethods__["intensities"] = _playerc.player_ranger_data_intns_t_intensities_set
    __swig_getmethods__["intensities"] = _playerc.player_ranger_data_intns_t_intensities_get
    if _newclass:intensities = property(_playerc.player_ranger_data_intns_t_intensities_get, _playerc.player_ranger_data_intns_t_intensities_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ranger_data_intns_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ranger_data_intns_t
    __del__ = lambda self : None;
player_ranger_data_intns_t_swigregister = _playerc.player_ranger_data_intns_t_swigregister
player_ranger_data_intns_t_swigregister(player_ranger_data_intns_t)

class player_ranger_data_intnsstamped_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ranger_data_intnsstamped_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ranger_data_intnsstamped_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["data"] = _playerc.player_ranger_data_intnsstamped_t_data_set
    __swig_getmethods__["data"] = _playerc.player_ranger_data_intnsstamped_t_data_get
    if _newclass:data = property(_playerc.player_ranger_data_intnsstamped_t_data_get, _playerc.player_ranger_data_intnsstamped_t_data_set)
    __swig_setmethods__["have_geom"] = _playerc.player_ranger_data_intnsstamped_t_have_geom_set
    __swig_getmethods__["have_geom"] = _playerc.player_ranger_data_intnsstamped_t_have_geom_get
    if _newclass:have_geom = property(_playerc.player_ranger_data_intnsstamped_t_have_geom_get, _playerc.player_ranger_data_intnsstamped_t_have_geom_set)
    __swig_setmethods__["geom"] = _playerc.player_ranger_data_intnsstamped_t_geom_set
    __swig_getmethods__["geom"] = _playerc.player_ranger_data_intnsstamped_t_geom_get
    if _newclass:geom = property(_playerc.player_ranger_data_intnsstamped_t_geom_get, _playerc.player_ranger_data_intnsstamped_t_geom_set)
    __swig_setmethods__["have_config"] = _playerc.player_ranger_data_intnsstamped_t_have_config_set
    __swig_getmethods__["have_config"] = _playerc.player_ranger_data_intnsstamped_t_have_config_get
    if _newclass:have_config = property(_playerc.player_ranger_data_intnsstamped_t_have_config_get, _playerc.player_ranger_data_intnsstamped_t_have_config_set)
    __swig_setmethods__["config"] = _playerc.player_ranger_data_intnsstamped_t_config_set
    __swig_getmethods__["config"] = _playerc.player_ranger_data_intnsstamped_t_config_get
    if _newclass:config = property(_playerc.player_ranger_data_intnsstamped_t_config_get, _playerc.player_ranger_data_intnsstamped_t_config_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ranger_data_intnsstamped_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ranger_data_intnsstamped_t
    __del__ = lambda self : None;
player_ranger_data_intnsstamped_t_swigregister = _playerc.player_ranger_data_intnsstamped_t_swigregister
player_ranger_data_intnsstamped_t_swigregister(player_ranger_data_intnsstamped_t)

class player_ranger_power_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ranger_power_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ranger_power_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_ranger_power_config_t_state_set
    __swig_getmethods__["state"] = _playerc.player_ranger_power_config_t_state_get
    if _newclass:state = property(_playerc.player_ranger_power_config_t_state_get, _playerc.player_ranger_power_config_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ranger_power_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ranger_power_config_t
    __del__ = lambda self : None;
player_ranger_power_config_t_swigregister = _playerc.player_ranger_power_config_t_swigregister
player_ranger_power_config_t_swigregister(player_ranger_power_config_t)

class player_ranger_intns_config_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_ranger_intns_config_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_ranger_intns_config_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["state"] = _playerc.player_ranger_intns_config_t_state_set
    __swig_getmethods__["state"] = _playerc.player_ranger_intns_config_t_state_get
    if _newclass:state = property(_playerc.player_ranger_intns_config_t_state_get, _playerc.player_ranger_intns_config_t_state_set)
    def __init__(self, *args): 
        this = _playerc.new_player_ranger_intns_config_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_ranger_intns_config_t
    __del__ = lambda self : None;
player_ranger_intns_config_t_swigregister = _playerc.player_ranger_intns_config_t_swigregister
player_ranger_intns_config_t_swigregister(player_ranger_intns_config_t)

PLAYER_VECTORMAP_CODE = _playerc.PLAYER_VECTORMAP_CODE
PLAYER_VECTORMAP_STRING = _playerc.PLAYER_VECTORMAP_STRING
PLAYER_VECTORMAP_REQ_GET_MAP_INFO = _playerc.PLAYER_VECTORMAP_REQ_GET_MAP_INFO
PLAYER_VECTORMAP_REQ_GET_LAYER_DATA = _playerc.PLAYER_VECTORMAP_REQ_GET_LAYER_DATA
PLAYER_VECTORMAP_REQ_WRITE_LAYER = _playerc.PLAYER_VECTORMAP_REQ_WRITE_LAYER
class player_vectormap_feature_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_vectormap_feature_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_vectormap_feature_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["name_count"] = _playerc.player_vectormap_feature_data_t_name_count_set
    __swig_getmethods__["name_count"] = _playerc.player_vectormap_feature_data_t_name_count_get
    if _newclass:name_count = property(_playerc.player_vectormap_feature_data_t_name_count_get, _playerc.player_vectormap_feature_data_t_name_count_set)
    __swig_setmethods__["name"] = _playerc.player_vectormap_feature_data_t_name_set
    __swig_getmethods__["name"] = _playerc.player_vectormap_feature_data_t_name_get
    if _newclass:name = property(_playerc.player_vectormap_feature_data_t_name_get, _playerc.player_vectormap_feature_data_t_name_set)
    __swig_setmethods__["wkb_count"] = _playerc.player_vectormap_feature_data_t_wkb_count_set
    __swig_getmethods__["wkb_count"] = _playerc.player_vectormap_feature_data_t_wkb_count_get
    if _newclass:wkb_count = property(_playerc.player_vectormap_feature_data_t_wkb_count_get, _playerc.player_vectormap_feature_data_t_wkb_count_set)
    __swig_setmethods__["wkb"] = _playerc.player_vectormap_feature_data_t_wkb_set
    __swig_getmethods__["wkb"] = _playerc.player_vectormap_feature_data_t_wkb_get
    if _newclass:wkb = property(_playerc.player_vectormap_feature_data_t_wkb_get, _playerc.player_vectormap_feature_data_t_wkb_set)
    __swig_setmethods__["attrib_count"] = _playerc.player_vectormap_feature_data_t_attrib_count_set
    __swig_getmethods__["attrib_count"] = _playerc.player_vectormap_feature_data_t_attrib_count_get
    if _newclass:attrib_count = property(_playerc.player_vectormap_feature_data_t_attrib_count_get, _playerc.player_vectormap_feature_data_t_attrib_count_set)
    __swig_setmethods__["attrib"] = _playerc.player_vectormap_feature_data_t_attrib_set
    __swig_getmethods__["attrib"] = _playerc.player_vectormap_feature_data_t_attrib_get
    if _newclass:attrib = property(_playerc.player_vectormap_feature_data_t_attrib_get, _playerc.player_vectormap_feature_data_t_attrib_set)
    def __init__(self, *args): 
        this = _playerc.new_player_vectormap_feature_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_vectormap_feature_data_t
    __del__ = lambda self : None;
player_vectormap_feature_data_t_swigregister = _playerc.player_vectormap_feature_data_t_swigregister
player_vectormap_feature_data_t_swigregister(player_vectormap_feature_data_t)

class player_vectormap_layer_info_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_vectormap_layer_info_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_vectormap_layer_info_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["name_count"] = _playerc.player_vectormap_layer_info_t_name_count_set
    __swig_getmethods__["name_count"] = _playerc.player_vectormap_layer_info_t_name_count_get
    if _newclass:name_count = property(_playerc.player_vectormap_layer_info_t_name_count_get, _playerc.player_vectormap_layer_info_t_name_count_set)
    __swig_setmethods__["name"] = _playerc.player_vectormap_layer_info_t_name_set
    __swig_getmethods__["name"] = _playerc.player_vectormap_layer_info_t_name_get
    if _newclass:name = property(_playerc.player_vectormap_layer_info_t_name_get, _playerc.player_vectormap_layer_info_t_name_set)
    __swig_setmethods__["extent"] = _playerc.player_vectormap_layer_info_t_extent_set
    __swig_getmethods__["extent"] = _playerc.player_vectormap_layer_info_t_extent_get
    if _newclass:extent = property(_playerc.player_vectormap_layer_info_t_extent_get, _playerc.player_vectormap_layer_info_t_extent_set)
    def __init__(self, *args): 
        this = _playerc.new_player_vectormap_layer_info_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_vectormap_layer_info_t
    __del__ = lambda self : None;
player_vectormap_layer_info_t_swigregister = _playerc.player_vectormap_layer_info_t_swigregister
player_vectormap_layer_info_t_swigregister(player_vectormap_layer_info_t)

class player_vectormap_layer_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_vectormap_layer_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_vectormap_layer_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["name_count"] = _playerc.player_vectormap_layer_data_t_name_count_set
    __swig_getmethods__["name_count"] = _playerc.player_vectormap_layer_data_t_name_count_get
    if _newclass:name_count = property(_playerc.player_vectormap_layer_data_t_name_count_get, _playerc.player_vectormap_layer_data_t_name_count_set)
    __swig_setmethods__["name"] = _playerc.player_vectormap_layer_data_t_name_set
    __swig_getmethods__["name"] = _playerc.player_vectormap_layer_data_t_name_get
    if _newclass:name = property(_playerc.player_vectormap_layer_data_t_name_get, _playerc.player_vectormap_layer_data_t_name_set)
    __swig_setmethods__["features_count"] = _playerc.player_vectormap_layer_data_t_features_count_set
    __swig_getmethods__["features_count"] = _playerc.player_vectormap_layer_data_t_features_count_get
    if _newclass:features_count = property(_playerc.player_vectormap_layer_data_t_features_count_get, _playerc.player_vectormap_layer_data_t_features_count_set)
    __swig_setmethods__["features"] = _playerc.player_vectormap_layer_data_t_features_set
    __swig_getmethods__["features"] = _playerc.player_vectormap_layer_data_t_features_get
    if _newclass:features = property(_playerc.player_vectormap_layer_data_t_features_get, _playerc.player_vectormap_layer_data_t_features_set)
    def __init__(self, *args): 
        this = _playerc.new_player_vectormap_layer_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_vectormap_layer_data_t
    __del__ = lambda self : None;
player_vectormap_layer_data_t_swigregister = _playerc.player_vectormap_layer_data_t_swigregister
player_vectormap_layer_data_t_swigregister(player_vectormap_layer_data_t)

class player_vectormap_info_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_vectormap_info_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_vectormap_info_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["srid"] = _playerc.player_vectormap_info_t_srid_set
    __swig_getmethods__["srid"] = _playerc.player_vectormap_info_t_srid_get
    if _newclass:srid = property(_playerc.player_vectormap_info_t_srid_get, _playerc.player_vectormap_info_t_srid_set)
    __swig_setmethods__["layers_count"] = _playerc.player_vectormap_info_t_layers_count_set
    __swig_getmethods__["layers_count"] = _playerc.player_vectormap_info_t_layers_count_get
    if _newclass:layers_count = property(_playerc.player_vectormap_info_t_layers_count_get, _playerc.player_vectormap_info_t_layers_count_set)
    __swig_setmethods__["layers"] = _playerc.player_vectormap_info_t_layers_set
    __swig_getmethods__["layers"] = _playerc.player_vectormap_info_t_layers_get
    if _newclass:layers = property(_playerc.player_vectormap_info_t_layers_get, _playerc.player_vectormap_info_t_layers_set)
    __swig_setmethods__["extent"] = _playerc.player_vectormap_info_t_extent_set
    __swig_getmethods__["extent"] = _playerc.player_vectormap_info_t_extent_get
    if _newclass:extent = property(_playerc.player_vectormap_info_t_extent_get, _playerc.player_vectormap_info_t_extent_set)
    def __init__(self, *args): 
        this = _playerc.new_player_vectormap_info_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_vectormap_info_t
    __del__ = lambda self : None;
player_vectormap_info_t_swigregister = _playerc.player_vectormap_info_t_swigregister
player_vectormap_info_t_swigregister(player_vectormap_info_t)

PLAYER_BLACKBOARD_CODE = _playerc.PLAYER_BLACKBOARD_CODE
PLAYER_BLACKBOARD_STRING = _playerc.PLAYER_BLACKBOARD_STRING
PLAYER_BLACKBOARD_REQ_SUBSCRIBE_TO_KEY = _playerc.PLAYER_BLACKBOARD_REQ_SUBSCRIBE_TO_KEY
PLAYER_BLACKBOARD_REQ_UNSUBSCRIBE_FROM_KEY = _playerc.PLAYER_BLACKBOARD_REQ_UNSUBSCRIBE_FROM_KEY
PLAYER_BLACKBOARD_REQ_SET_ENTRY = _playerc.PLAYER_BLACKBOARD_REQ_SET_ENTRY
PLAYER_BLACKBOARD_REQ_SUBSCRIBE_TO_GROUP = _playerc.PLAYER_BLACKBOARD_REQ_SUBSCRIBE_TO_GROUP
PLAYER_BLACKBOARD_REQ_UNSUBSCRIBE_FROM_GROUP = _playerc.PLAYER_BLACKBOARD_REQ_UNSUBSCRIBE_FROM_GROUP
PLAYER_BLACKBOARD_REQ_GET_ENTRY = _playerc.PLAYER_BLACKBOARD_REQ_GET_ENTRY
PLAYER_BLACKBOARD_DATA_UPDATE = _playerc.PLAYER_BLACKBOARD_DATA_UPDATE
PLAYER_STEREO_CODE = _playerc.PLAYER_STEREO_CODE
PLAYER_STEREO_STRING = _playerc.PLAYER_STEREO_STRING
PLAYER_STEREO_DATA_STATE = _playerc.PLAYER_STEREO_DATA_STATE
class player_pointcloud3d_stereo_element_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_pointcloud3d_stereo_element_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_pointcloud3d_stereo_element_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["px"] = _playerc.player_pointcloud3d_stereo_element_t_px_set
    __swig_getmethods__["px"] = _playerc.player_pointcloud3d_stereo_element_t_px_get
    if _newclass:px = property(_playerc.player_pointcloud3d_stereo_element_t_px_get, _playerc.player_pointcloud3d_stereo_element_t_px_set)
    __swig_setmethods__["py"] = _playerc.player_pointcloud3d_stereo_element_t_py_set
    __swig_getmethods__["py"] = _playerc.player_pointcloud3d_stereo_element_t_py_get
    if _newclass:py = property(_playerc.player_pointcloud3d_stereo_element_t_py_get, _playerc.player_pointcloud3d_stereo_element_t_py_set)
    __swig_setmethods__["pz"] = _playerc.player_pointcloud3d_stereo_element_t_pz_set
    __swig_getmethods__["pz"] = _playerc.player_pointcloud3d_stereo_element_t_pz_get
    if _newclass:pz = property(_playerc.player_pointcloud3d_stereo_element_t_pz_get, _playerc.player_pointcloud3d_stereo_element_t_pz_set)
    __swig_setmethods__["red"] = _playerc.player_pointcloud3d_stereo_element_t_red_set
    __swig_getmethods__["red"] = _playerc.player_pointcloud3d_stereo_element_t_red_get
    if _newclass:red = property(_playerc.player_pointcloud3d_stereo_element_t_red_get, _playerc.player_pointcloud3d_stereo_element_t_red_set)
    __swig_setmethods__["green"] = _playerc.player_pointcloud3d_stereo_element_t_green_set
    __swig_getmethods__["green"] = _playerc.player_pointcloud3d_stereo_element_t_green_get
    if _newclass:green = property(_playerc.player_pointcloud3d_stereo_element_t_green_get, _playerc.player_pointcloud3d_stereo_element_t_green_set)
    __swig_setmethods__["blue"] = _playerc.player_pointcloud3d_stereo_element_t_blue_set
    __swig_getmethods__["blue"] = _playerc.player_pointcloud3d_stereo_element_t_blue_get
    if _newclass:blue = property(_playerc.player_pointcloud3d_stereo_element_t_blue_get, _playerc.player_pointcloud3d_stereo_element_t_blue_set)
    def __init__(self, *args): 
        this = _playerc.new_player_pointcloud3d_stereo_element_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_pointcloud3d_stereo_element_t
    __del__ = lambda self : None;
player_pointcloud3d_stereo_element_t_swigregister = _playerc.player_pointcloud3d_stereo_element_t_swigregister
player_pointcloud3d_stereo_element_t_swigregister(player_pointcloud3d_stereo_element_t)

class player_stereo_data_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, player_stereo_data_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, player_stereo_data_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["left_channel"] = _playerc.player_stereo_data_t_left_channel_set
    __swig_getmethods__["left_channel"] = _playerc.player_stereo_data_t_left_channel_get
    if _newclass:left_channel = property(_playerc.player_stereo_data_t_left_channel_get, _playerc.player_stereo_data_t_left_channel_set)
    __swig_setmethods__["right_channel"] = _playerc.player_stereo_data_t_right_channel_set
    __swig_getmethods__["right_channel"] = _playerc.player_stereo_data_t_right_channel_get
    if _newclass:right_channel = property(_playerc.player_stereo_data_t_right_channel_get, _playerc.player_stereo_data_t_right_channel_set)
    __swig_setmethods__["disparity"] = _playerc.player_stereo_data_t_disparity_set
    __swig_getmethods__["disparity"] = _playerc.player_stereo_data_t_disparity_get
    if _newclass:disparity = property(_playerc.player_stereo_data_t_disparity_get, _playerc.player_stereo_data_t_disparity_set)
    __swig_setmethods__["points_count"] = _playerc.player_stereo_data_t_points_count_set
    __swig_getmethods__["points_count"] = _playerc.player_stereo_data_t_points_count_get
    if _newclass:points_count = property(_playerc.player_stereo_data_t_points_count_get, _playerc.player_stereo_data_t_points_count_set)
    __swig_setmethods__["points"] = _playerc.player_stereo_data_t_points_set
    __swig_getmethods__["points"] = _playerc.player_stereo_data_t_points_get
    if _newclass:points = property(_playerc.player_stereo_data_t_points_get, _playerc.player_stereo_data_t_points_set)
    __swig_setmethods__["mode"] = _playerc.player_stereo_data_t_mode_set
    __swig_getmethods__["mode"] = _playerc.player_stereo_data_t_mode_get
    if _newclass:mode = property(_playerc.player_stereo_data_t_mode_get, _playerc.player_stereo_data_t_mode_set)
    def __init__(self, *args): 
        this = _playerc.new_player_stereo_data_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_player_stereo_data_t
    __del__ = lambda self : None;
player_stereo_data_t_swigregister = _playerc.player_stereo_data_t_swigregister
player_stereo_data_t_swigregister(player_stereo_data_t)

class intArray(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, intArray, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, intArray, name)
    __repr__ = _swig_repr
    __swig_setmethods__["actual"] = _playerc.intArray_actual_set
    __swig_getmethods__["actual"] = _playerc.intArray_actual_get
    if _newclass:actual = property(_playerc.intArray_actual_get, _playerc.intArray_actual_set)
    def __getitem__(*args): return _playerc.intArray___getitem__(*args)
    def __setitem__(*args): return _playerc.intArray___setitem__(*args)
    def __init__(self, *args): 
        this = _playerc.new_intArray(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_intArray
    __del__ = lambda self : None;
intArray_swigregister = _playerc.intArray_swigregister
intArray_swigregister(intArray)

class doubleArray(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, doubleArray, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, doubleArray, name)
    __repr__ = _swig_repr
    __swig_setmethods__["actual"] = _playerc.doubleArray_actual_set
    __swig_getmethods__["actual"] = _playerc.doubleArray_actual_get
    if _newclass:actual = property(_playerc.doubleArray_actual_get, _playerc.doubleArray_actual_set)
    def __getitem__(*args): return _playerc.doubleArray___getitem__(*args)
    def __setitem__(*args): return _playerc.doubleArray___setitem__(*args)
    def __init__(self, *args): 
        this = _playerc.new_doubleArray(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_doubleArray
    __del__ = lambda self : None;
doubleArray_swigregister = _playerc.doubleArray_swigregister
doubleArray_swigregister(doubleArray)

class floatArray(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, floatArray, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, floatArray, name)
    __repr__ = _swig_repr
    __swig_setmethods__["actual"] = _playerc.floatArray_actual_set
    __swig_getmethods__["actual"] = _playerc.floatArray_actual_get
    if _newclass:actual = property(_playerc.floatArray_actual_get, _playerc.floatArray_actual_set)
    def __getitem__(*args): return _playerc.floatArray___getitem__(*args)
    def __setitem__(*args): return _playerc.floatArray___setitem__(*args)
    def __init__(self, *args): 
        this = _playerc.new_floatArray(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_floatArray
    __del__ = lambda self : None;
floatArray_swigregister = _playerc.floatArray_swigregister
floatArray_swigregister(floatArray)

PLAYERC_OPEN_MODE = _playerc.PLAYERC_OPEN_MODE
PLAYERC_CLOSE_MODE = _playerc.PLAYERC_CLOSE_MODE
PLAYERC_ERROR_MODE = _playerc.PLAYERC_ERROR_MODE
PLAYERC_DATAMODE_PUSH = _playerc.PLAYERC_DATAMODE_PUSH
PLAYERC_DATAMODE_PULL = _playerc.PLAYERC_DATAMODE_PULL
PLAYERC_TRANSPORT_TCP = _playerc.PLAYERC_TRANSPORT_TCP
PLAYERC_TRANSPORT_UDP = _playerc.PLAYERC_TRANSPORT_UDP
PLAYERC_QUEUE_RING_SIZE = _playerc.PLAYERC_QUEUE_RING_SIZE
playerc_error_str = _playerc.playerc_error_str
playerc_add_xdr_ftable = _playerc.playerc_add_xdr_ftable
class playerc_client_item(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_client_item, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_client_item, name)
    __repr__ = _swig_repr
    __swig_setmethods__["header"] = _playerc.playerc_client_item_header_set
    __swig_getmethods__["header"] = _playerc.playerc_client_item_header_get
    if _newclass:header = property(_playerc.playerc_client_item_header_get, _playerc.playerc_client_item_header_set)
    __swig_setmethods__["data"] = _playerc.playerc_client_item_data_set
    __swig_getmethods__["data"] = _playerc.playerc_client_item_data_get
    if _newclass:data = property(_playerc.playerc_client_item_data_get, _playerc.playerc_client_item_data_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_client_item(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_playerc_client_item
    __del__ = lambda self : None;
playerc_client_item_swigregister = _playerc.playerc_client_item_swigregister
playerc_client_item_swigregister(playerc_client_item)

class playerc_mclient(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_mclient, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_mclient, name)
    __repr__ = _swig_repr
    __swig_setmethods__["client_count"] = _playerc.playerc_mclient_client_count_set
    __swig_getmethods__["client_count"] = _playerc.playerc_mclient_client_count_get
    if _newclass:client_count = property(_playerc.playerc_mclient_client_count_get, _playerc.playerc_mclient_client_count_set)
    __swig_setmethods__["client"] = _playerc.playerc_mclient_client_set
    __swig_getmethods__["client"] = _playerc.playerc_mclient_client_get
    if _newclass:client = property(_playerc.playerc_mclient_client_get, _playerc.playerc_mclient_client_set)
    __swig_setmethods__["pollfd"] = _playerc.playerc_mclient_pollfd_set
    __swig_getmethods__["pollfd"] = _playerc.playerc_mclient_pollfd_get
    if _newclass:pollfd = property(_playerc.playerc_mclient_pollfd_get, _playerc.playerc_mclient_pollfd_set)
    __swig_setmethods__["time"] = _playerc.playerc_mclient_time_set
    __swig_getmethods__["time"] = _playerc.playerc_mclient_time_get
    if _newclass:time = property(_playerc.playerc_mclient_time_get, _playerc.playerc_mclient_time_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_mclient(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_mclient_destroy(*args)
    def addclient(*args): return _playerc.playerc_mclient_addclient(*args)
    def peek(*args): return _playerc.playerc_mclient_peek(*args)
    def read(*args): return _playerc.playerc_mclient_read(*args)
    __swig_destroy__ = _playerc.delete_playerc_mclient
    __del__ = lambda self : None;
playerc_mclient_swigregister = _playerc.playerc_mclient_swigregister
playerc_mclient_swigregister(playerc_mclient)

class playerc_device_info(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_device_info, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_device_info, name)
    __repr__ = _swig_repr
    __swig_setmethods__["addr"] = _playerc.playerc_device_info_addr_set
    __swig_getmethods__["addr"] = _playerc.playerc_device_info_addr_get
    if _newclass:addr = property(_playerc.playerc_device_info_addr_get, _playerc.playerc_device_info_addr_set)
    __swig_setmethods__["drivername"] = _playerc.playerc_device_info_drivername_set
    __swig_getmethods__["drivername"] = _playerc.playerc_device_info_drivername_get
    if _newclass:drivername = property(_playerc.playerc_device_info_drivername_get, _playerc.playerc_device_info_drivername_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_device_info(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_playerc_device_info
    __del__ = lambda self : None;
playerc_device_info_swigregister = _playerc.playerc_device_info_swigregister
playerc_device_info_swigregister(playerc_device_info)

class playerc_client(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_client, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_client, name)
    __repr__ = _swig_repr
    __swig_setmethods__["id"] = _playerc.playerc_client_id_set
    __swig_getmethods__["id"] = _playerc.playerc_client_id_get
    if _newclass:id = property(_playerc.playerc_client_id_get, _playerc.playerc_client_id_set)
    __swig_setmethods__["host"] = _playerc.playerc_client_host_set
    __swig_getmethods__["host"] = _playerc.playerc_client_host_get
    if _newclass:host = property(_playerc.playerc_client_host_get, _playerc.playerc_client_host_set)
    __swig_setmethods__["port"] = _playerc.playerc_client_port_set
    __swig_getmethods__["port"] = _playerc.playerc_client_port_get
    if _newclass:port = property(_playerc.playerc_client_port_get, _playerc.playerc_client_port_set)
    __swig_setmethods__["transport"] = _playerc.playerc_client_transport_set
    __swig_getmethods__["transport"] = _playerc.playerc_client_transport_get
    if _newclass:transport = property(_playerc.playerc_client_transport_get, _playerc.playerc_client_transport_set)
    __swig_setmethods__["server"] = _playerc.playerc_client_server_set
    __swig_getmethods__["server"] = _playerc.playerc_client_server_get
    if _newclass:server = property(_playerc.playerc_client_server_get, _playerc.playerc_client_server_set)
    __swig_setmethods__["connected"] = _playerc.playerc_client_connected_set
    __swig_getmethods__["connected"] = _playerc.playerc_client_connected_get
    if _newclass:connected = property(_playerc.playerc_client_connected_get, _playerc.playerc_client_connected_set)
    __swig_setmethods__["retry_limit"] = _playerc.playerc_client_retry_limit_set
    __swig_getmethods__["retry_limit"] = _playerc.playerc_client_retry_limit_get
    if _newclass:retry_limit = property(_playerc.playerc_client_retry_limit_get, _playerc.playerc_client_retry_limit_set)
    __swig_setmethods__["retry_time"] = _playerc.playerc_client_retry_time_set
    __swig_getmethods__["retry_time"] = _playerc.playerc_client_retry_time_get
    if _newclass:retry_time = property(_playerc.playerc_client_retry_time_get, _playerc.playerc_client_retry_time_set)
    __swig_setmethods__["overflow_count"] = _playerc.playerc_client_overflow_count_set
    __swig_getmethods__["overflow_count"] = _playerc.playerc_client_overflow_count_get
    if _newclass:overflow_count = property(_playerc.playerc_client_overflow_count_get, _playerc.playerc_client_overflow_count_set)
    __swig_setmethods__["sock"] = _playerc.playerc_client_sock_set
    __swig_getmethods__["sock"] = _playerc.playerc_client_sock_get
    if _newclass:sock = property(_playerc.playerc_client_sock_get, _playerc.playerc_client_sock_set)
    __swig_setmethods__["mode"] = _playerc.playerc_client_mode_set
    __swig_getmethods__["mode"] = _playerc.playerc_client_mode_get
    if _newclass:mode = property(_playerc.playerc_client_mode_get, _playerc.playerc_client_mode_set)
    __swig_setmethods__["data_requested"] = _playerc.playerc_client_data_requested_set
    __swig_getmethods__["data_requested"] = _playerc.playerc_client_data_requested_get
    if _newclass:data_requested = property(_playerc.playerc_client_data_requested_get, _playerc.playerc_client_data_requested_set)
    __swig_setmethods__["data_received"] = _playerc.playerc_client_data_received_set
    __swig_getmethods__["data_received"] = _playerc.playerc_client_data_received_get
    if _newclass:data_received = property(_playerc.playerc_client_data_received_get, _playerc.playerc_client_data_received_set)
    __swig_setmethods__["devinfos"] = _playerc.playerc_client_devinfos_set
    __swig_getmethods__["devinfos"] = _playerc.playerc_client_devinfos_get
    if _newclass:devinfos = property(_playerc.playerc_client_devinfos_get, _playerc.playerc_client_devinfos_set)
    __swig_setmethods__["devinfo_count"] = _playerc.playerc_client_devinfo_count_set
    __swig_getmethods__["devinfo_count"] = _playerc.playerc_client_devinfo_count_get
    if _newclass:devinfo_count = property(_playerc.playerc_client_devinfo_count_get, _playerc.playerc_client_devinfo_count_set)
    __swig_setmethods__["device"] = _playerc.playerc_client_device_set
    __swig_getmethods__["device"] = _playerc.playerc_client_device_get
    if _newclass:device = property(_playerc.playerc_client_device_get, _playerc.playerc_client_device_set)
    __swig_setmethods__["device_count"] = _playerc.playerc_client_device_count_set
    __swig_getmethods__["device_count"] = _playerc.playerc_client_device_count_get
    if _newclass:device_count = property(_playerc.playerc_client_device_count_get, _playerc.playerc_client_device_count_set)
    __swig_setmethods__["qitems"] = _playerc.playerc_client_qitems_set
    __swig_getmethods__["qitems"] = _playerc.playerc_client_qitems_get
    if _newclass:qitems = property(_playerc.playerc_client_qitems_get, _playerc.playerc_client_qitems_set)
    __swig_setmethods__["qfirst"] = _playerc.playerc_client_qfirst_set
    __swig_getmethods__["qfirst"] = _playerc.playerc_client_qfirst_get
    if _newclass:qfirst = property(_playerc.playerc_client_qfirst_get, _playerc.playerc_client_qfirst_set)
    __swig_setmethods__["qlen"] = _playerc.playerc_client_qlen_set
    __swig_getmethods__["qlen"] = _playerc.playerc_client_qlen_get
    if _newclass:qlen = property(_playerc.playerc_client_qlen_get, _playerc.playerc_client_qlen_set)
    __swig_setmethods__["qsize"] = _playerc.playerc_client_qsize_set
    __swig_getmethods__["qsize"] = _playerc.playerc_client_qsize_get
    if _newclass:qsize = property(_playerc.playerc_client_qsize_get, _playerc.playerc_client_qsize_set)
    __swig_setmethods__["data"] = _playerc.playerc_client_data_set
    __swig_getmethods__["data"] = _playerc.playerc_client_data_get
    if _newclass:data = property(_playerc.playerc_client_data_get, _playerc.playerc_client_data_set)
    __swig_setmethods__["write_xdrdata"] = _playerc.playerc_client_write_xdrdata_set
    __swig_getmethods__["write_xdrdata"] = _playerc.playerc_client_write_xdrdata_get
    if _newclass:write_xdrdata = property(_playerc.playerc_client_write_xdrdata_get, _playerc.playerc_client_write_xdrdata_set)
    __swig_setmethods__["read_xdrdata"] = _playerc.playerc_client_read_xdrdata_set
    __swig_getmethods__["read_xdrdata"] = _playerc.playerc_client_read_xdrdata_get
    if _newclass:read_xdrdata = property(_playerc.playerc_client_read_xdrdata_get, _playerc.playerc_client_read_xdrdata_set)
    __swig_setmethods__["read_xdrdata_len"] = _playerc.playerc_client_read_xdrdata_len_set
    __swig_getmethods__["read_xdrdata_len"] = _playerc.playerc_client_read_xdrdata_len_get
    if _newclass:read_xdrdata_len = property(_playerc.playerc_client_read_xdrdata_len_get, _playerc.playerc_client_read_xdrdata_len_set)
    __swig_setmethods__["datatime"] = _playerc.playerc_client_datatime_set
    __swig_getmethods__["datatime"] = _playerc.playerc_client_datatime_get
    if _newclass:datatime = property(_playerc.playerc_client_datatime_get, _playerc.playerc_client_datatime_set)
    __swig_setmethods__["lasttime"] = _playerc.playerc_client_lasttime_set
    __swig_getmethods__["lasttime"] = _playerc.playerc_client_lasttime_get
    if _newclass:lasttime = property(_playerc.playerc_client_lasttime_get, _playerc.playerc_client_lasttime_set)
    __swig_setmethods__["request_timeout"] = _playerc.playerc_client_request_timeout_set
    __swig_getmethods__["request_timeout"] = _playerc.playerc_client_request_timeout_get
    if _newclass:request_timeout = property(_playerc.playerc_client_request_timeout_get, _playerc.playerc_client_request_timeout_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_client(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_client_destroy(*args)
    def set_transport(*args): return _playerc.playerc_client_set_transport(*args)
    def connect(*args): return _playerc.playerc_client_connect(*args)
    def disconnect(*args): return _playerc.playerc_client_disconnect(*args)
    def disconnect_retry(*args): return _playerc.playerc_client_disconnect_retry(*args)
    def datamode(*args): return _playerc.playerc_client_datamode(*args)
    def requestdata(*args): return _playerc.playerc_client_requestdata(*args)
    def set_replace_rule(*args): return _playerc.playerc_client_set_replace_rule(*args)
    def adddevice(*args): return _playerc.playerc_client_adddevice(*args)
    def deldevice(*args): return _playerc.playerc_client_deldevice(*args)
    def addcallback(*args): return _playerc.playerc_client_addcallback(*args)
    def delcallback(*args): return _playerc.playerc_client_delcallback(*args)
    def get_devlist(*args): return _playerc.playerc_client_get_devlist(*args)
    def subscribe(*args): return _playerc.playerc_client_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_client_unsubscribe(*args)
    def request(*args): return _playerc.playerc_client_request(*args)
    def peek(*args): return _playerc.playerc_client_peek(*args)
    def internal_peek(*args): return _playerc.playerc_client_internal_peek(*args)
    def read(*args): return _playerc.playerc_client_read(*args)
    def read_nonblock(*args): return _playerc.playerc_client_read_nonblock(*args)
    def read_nonblock_withproxy(*args): return _playerc.playerc_client_read_nonblock_withproxy(*args)
    def set_request_timeout(*args): return _playerc.playerc_client_set_request_timeout(*args)
    def set_retry_limit(*args): return _playerc.playerc_client_set_retry_limit(*args)
    def set_retry_time(*args): return _playerc.playerc_client_set_retry_time(*args)
    def write(*args): return _playerc.playerc_client_write(*args)
    __swig_destroy__ = _playerc.delete_playerc_client
    __del__ = lambda self : None;
playerc_client_swigregister = _playerc.playerc_client_swigregister
playerc_client_swigregister(playerc_client)

class playerc_device(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_device, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_device, name)
    __repr__ = _swig_repr
    __swig_setmethods__["id"] = _playerc.playerc_device_id_set
    __swig_getmethods__["id"] = _playerc.playerc_device_id_get
    if _newclass:id = property(_playerc.playerc_device_id_get, _playerc.playerc_device_id_set)
    __swig_setmethods__["client"] = _playerc.playerc_device_client_set
    __swig_getmethods__["client"] = _playerc.playerc_device_client_get
    if _newclass:client = property(_playerc.playerc_device_client_get, _playerc.playerc_device_client_set)
    __swig_setmethods__["addr"] = _playerc.playerc_device_addr_set
    __swig_getmethods__["addr"] = _playerc.playerc_device_addr_get
    if _newclass:addr = property(_playerc.playerc_device_addr_get, _playerc.playerc_device_addr_set)
    __swig_setmethods__["drivername"] = _playerc.playerc_device_drivername_set
    __swig_getmethods__["drivername"] = _playerc.playerc_device_drivername_get
    if _newclass:drivername = property(_playerc.playerc_device_drivername_get, _playerc.playerc_device_drivername_set)
    __swig_setmethods__["subscribed"] = _playerc.playerc_device_subscribed_set
    __swig_getmethods__["subscribed"] = _playerc.playerc_device_subscribed_get
    if _newclass:subscribed = property(_playerc.playerc_device_subscribed_get, _playerc.playerc_device_subscribed_set)
    __swig_setmethods__["datatime"] = _playerc.playerc_device_datatime_set
    __swig_getmethods__["datatime"] = _playerc.playerc_device_datatime_get
    if _newclass:datatime = property(_playerc.playerc_device_datatime_get, _playerc.playerc_device_datatime_set)
    __swig_setmethods__["lasttime"] = _playerc.playerc_device_lasttime_set
    __swig_getmethods__["lasttime"] = _playerc.playerc_device_lasttime_get
    if _newclass:lasttime = property(_playerc.playerc_device_lasttime_get, _playerc.playerc_device_lasttime_set)
    __swig_setmethods__["fresh"] = _playerc.playerc_device_fresh_set
    __swig_getmethods__["fresh"] = _playerc.playerc_device_fresh_get
    if _newclass:fresh = property(_playerc.playerc_device_fresh_get, _playerc.playerc_device_fresh_set)
    __swig_setmethods__["freshgeom"] = _playerc.playerc_device_freshgeom_set
    __swig_getmethods__["freshgeom"] = _playerc.playerc_device_freshgeom_get
    if _newclass:freshgeom = property(_playerc.playerc_device_freshgeom_get, _playerc.playerc_device_freshgeom_set)
    __swig_setmethods__["freshconfig"] = _playerc.playerc_device_freshconfig_set
    __swig_getmethods__["freshconfig"] = _playerc.playerc_device_freshconfig_get
    if _newclass:freshconfig = property(_playerc.playerc_device_freshconfig_get, _playerc.playerc_device_freshconfig_set)
    __swig_setmethods__["putmsg"] = _playerc.playerc_device_putmsg_set
    __swig_getmethods__["putmsg"] = _playerc.playerc_device_putmsg_get
    if _newclass:putmsg = property(_playerc.playerc_device_putmsg_get, _playerc.playerc_device_putmsg_set)
    __swig_setmethods__["user_data"] = _playerc.playerc_device_user_data_set
    __swig_getmethods__["user_data"] = _playerc.playerc_device_user_data_get
    if _newclass:user_data = property(_playerc.playerc_device_user_data_get, _playerc.playerc_device_user_data_set)
    __swig_setmethods__["callback_count"] = _playerc.playerc_device_callback_count_set
    __swig_getmethods__["callback_count"] = _playerc.playerc_device_callback_count_get
    if _newclass:callback_count = property(_playerc.playerc_device_callback_count_get, _playerc.playerc_device_callback_count_set)
    __swig_setmethods__["callback"] = _playerc.playerc_device_callback_set
    __swig_getmethods__["callback"] = _playerc.playerc_device_callback_get
    if _newclass:callback = property(_playerc.playerc_device_callback_get, _playerc.playerc_device_callback_set)
    __swig_setmethods__["callback_data"] = _playerc.playerc_device_callback_data_set
    __swig_getmethods__["callback_data"] = _playerc.playerc_device_callback_data_get
    if _newclass:callback_data = property(_playerc.playerc_device_callback_data_get, _playerc.playerc_device_callback_data_set)
    def init(*args): return _playerc.playerc_device_init(*args)
    def term(*args): return _playerc.playerc_device_term(*args)
    def subscribe(*args): return _playerc.playerc_device_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_device_unsubscribe(*args)
    def hascapability(*args): return _playerc.playerc_device_hascapability(*args)
    def get_boolprop(*args): return _playerc.playerc_device_get_boolprop(*args)
    def set_boolprop(*args): return _playerc.playerc_device_set_boolprop(*args)
    def get_intprop(*args): return _playerc.playerc_device_get_intprop(*args)
    def set_intprop(*args): return _playerc.playerc_device_set_intprop(*args)
    def get_dblprop(*args): return _playerc.playerc_device_get_dblprop(*args)
    def set_dblprop(*args): return _playerc.playerc_device_set_dblprop(*args)
    def get_strprop(*args): return _playerc.playerc_device_get_strprop(*args)
    def set_strprop(*args): return _playerc.playerc_device_set_strprop(*args)
    def __init__(self, *args): 
        this = _playerc.new_playerc_device(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_playerc_device
    __del__ = lambda self : None;
playerc_device_swigregister = _playerc.playerc_device_swigregister
playerc_device_swigregister(playerc_device)

class playerc_aio(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_aio, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_aio, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_aio_info_set
    __swig_getmethods__["info"] = _playerc.playerc_aio_info_get
    if _newclass:info = property(_playerc.playerc_aio_info_get, _playerc.playerc_aio_info_set)
    __swig_setmethods__["voltages_count"] = _playerc.playerc_aio_voltages_count_set
    __swig_getmethods__["voltages_count"] = _playerc.playerc_aio_voltages_count_get
    if _newclass:voltages_count = property(_playerc.playerc_aio_voltages_count_get, _playerc.playerc_aio_voltages_count_set)
    __swig_setmethods__["voltages"] = _playerc.playerc_aio_voltages_set
    __swig_getmethods__["voltages"] = _playerc.playerc_aio_voltages_get
    if _newclass:voltages = property(_playerc.playerc_aio_voltages_get, _playerc.playerc_aio_voltages_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_aio(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_aio_destroy(*args)
    def subscribe(*args): return _playerc.playerc_aio_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_aio_unsubscribe(*args)
    def set_output(*args): return _playerc.playerc_aio_set_output(*args)
    def get_data(*args): return _playerc.playerc_aio_get_data(*args)
    __swig_destroy__ = _playerc.delete_playerc_aio
    __del__ = lambda self : None;
playerc_aio_swigregister = _playerc.playerc_aio_swigregister
playerc_aio_swigregister(playerc_aio)

PLAYERC_ACTARRAY_ACTSTATE_IDLE = _playerc.PLAYERC_ACTARRAY_ACTSTATE_IDLE
PLAYERC_ACTARRAY_ACTSTATE_MOVING = _playerc.PLAYERC_ACTARRAY_ACTSTATE_MOVING
PLAYERC_ACTARRAY_ACTSTATE_BRAKED = _playerc.PLAYERC_ACTARRAY_ACTSTATE_BRAKED
PLAYERC_ACTARRAY_ACTSTATE_STALLED = _playerc.PLAYERC_ACTARRAY_ACTSTATE_STALLED
PLAYERC_ACTARRAY_TYPE_LINEAR = _playerc.PLAYERC_ACTARRAY_TYPE_LINEAR
PLAYERC_ACTARRAY_TYPE_ROTARY = _playerc.PLAYERC_ACTARRAY_TYPE_ROTARY
class playerc_actarray(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_actarray, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_actarray, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_actarray_info_set
    __swig_getmethods__["info"] = _playerc.playerc_actarray_info_get
    if _newclass:info = property(_playerc.playerc_actarray_info_get, _playerc.playerc_actarray_info_set)
    __swig_setmethods__["actuators_count"] = _playerc.playerc_actarray_actuators_count_set
    __swig_getmethods__["actuators_count"] = _playerc.playerc_actarray_actuators_count_get
    if _newclass:actuators_count = property(_playerc.playerc_actarray_actuators_count_get, _playerc.playerc_actarray_actuators_count_set)
    __swig_setmethods__["actuators_data"] = _playerc.playerc_actarray_actuators_data_set
    __swig_getmethods__["actuators_data"] = _playerc.playerc_actarray_actuators_data_get
    if _newclass:actuators_data = property(_playerc.playerc_actarray_actuators_data_get, _playerc.playerc_actarray_actuators_data_set)
    __swig_setmethods__["actuators_geom_count"] = _playerc.playerc_actarray_actuators_geom_count_set
    __swig_getmethods__["actuators_geom_count"] = _playerc.playerc_actarray_actuators_geom_count_get
    if _newclass:actuators_geom_count = property(_playerc.playerc_actarray_actuators_geom_count_get, _playerc.playerc_actarray_actuators_geom_count_set)
    __swig_setmethods__["actuators_geom"] = _playerc.playerc_actarray_actuators_geom_set
    __swig_getmethods__["actuators_geom"] = _playerc.playerc_actarray_actuators_geom_get
    if _newclass:actuators_geom = property(_playerc.playerc_actarray_actuators_geom_get, _playerc.playerc_actarray_actuators_geom_set)
    __swig_setmethods__["motor_state"] = _playerc.playerc_actarray_motor_state_set
    __swig_getmethods__["motor_state"] = _playerc.playerc_actarray_motor_state_get
    if _newclass:motor_state = property(_playerc.playerc_actarray_motor_state_get, _playerc.playerc_actarray_motor_state_set)
    __swig_setmethods__["base_pos"] = _playerc.playerc_actarray_base_pos_set
    __swig_getmethods__["base_pos"] = _playerc.playerc_actarray_base_pos_get
    if _newclass:base_pos = property(_playerc.playerc_actarray_base_pos_get, _playerc.playerc_actarray_base_pos_set)
    __swig_setmethods__["base_orientation"] = _playerc.playerc_actarray_base_orientation_set
    __swig_getmethods__["base_orientation"] = _playerc.playerc_actarray_base_orientation_get
    if _newclass:base_orientation = property(_playerc.playerc_actarray_base_orientation_get, _playerc.playerc_actarray_base_orientation_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_actarray(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_actarray_destroy(*args)
    def subscribe(*args): return _playerc.playerc_actarray_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_actarray_unsubscribe(*args)
    def get_actuator_data(*args): return _playerc.playerc_actarray_get_actuator_data(*args)
    def get_actuator_geom(*args): return _playerc.playerc_actarray_get_actuator_geom(*args)
    def get_geom(*args): return _playerc.playerc_actarray_get_geom(*args)
    def position_cmd(*args): return _playerc.playerc_actarray_position_cmd(*args)
    def multi_position_cmd(*args): return _playerc.playerc_actarray_multi_position_cmd(*args)
    def speed_cmd(*args): return _playerc.playerc_actarray_speed_cmd(*args)
    def multi_speed_cmd(*args): return _playerc.playerc_actarray_multi_speed_cmd(*args)
    def home_cmd(*args): return _playerc.playerc_actarray_home_cmd(*args)
    def current_cmd(*args): return _playerc.playerc_actarray_current_cmd(*args)
    def multi_current_cmd(*args): return _playerc.playerc_actarray_multi_current_cmd(*args)
    def power(*args): return _playerc.playerc_actarray_power(*args)
    def brakes(*args): return _playerc.playerc_actarray_brakes(*args)
    def speed_config(*args): return _playerc.playerc_actarray_speed_config(*args)
    def accel_config(*args): return _playerc.playerc_actarray_accel_config(*args)
    __swig_destroy__ = _playerc.delete_playerc_actarray
    __del__ = lambda self : None;
playerc_actarray_swigregister = _playerc.playerc_actarray_swigregister
playerc_actarray_swigregister(playerc_actarray)

class playerc_audio(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_audio, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_audio, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_audio_info_set
    __swig_getmethods__["info"] = _playerc.playerc_audio_info_get
    if _newclass:info = property(_playerc.playerc_audio_info_get, _playerc.playerc_audio_info_set)
    __swig_setmethods__["channel_details_list"] = _playerc.playerc_audio_channel_details_list_set
    __swig_getmethods__["channel_details_list"] = _playerc.playerc_audio_channel_details_list_get
    if _newclass:channel_details_list = property(_playerc.playerc_audio_channel_details_list_get, _playerc.playerc_audio_channel_details_list_set)
    __swig_setmethods__["wav_data"] = _playerc.playerc_audio_wav_data_set
    __swig_getmethods__["wav_data"] = _playerc.playerc_audio_wav_data_get
    if _newclass:wav_data = property(_playerc.playerc_audio_wav_data_get, _playerc.playerc_audio_wav_data_set)
    __swig_setmethods__["seq_data"] = _playerc.playerc_audio_seq_data_set
    __swig_getmethods__["seq_data"] = _playerc.playerc_audio_seq_data_get
    if _newclass:seq_data = property(_playerc.playerc_audio_seq_data_get, _playerc.playerc_audio_seq_data_set)
    __swig_setmethods__["mixer_data"] = _playerc.playerc_audio_mixer_data_set
    __swig_getmethods__["mixer_data"] = _playerc.playerc_audio_mixer_data_get
    if _newclass:mixer_data = property(_playerc.playerc_audio_mixer_data_get, _playerc.playerc_audio_mixer_data_set)
    __swig_setmethods__["state"] = _playerc.playerc_audio_state_set
    __swig_getmethods__["state"] = _playerc.playerc_audio_state_get
    if _newclass:state = property(_playerc.playerc_audio_state_get, _playerc.playerc_audio_state_set)
    __swig_setmethods__["last_index"] = _playerc.playerc_audio_last_index_set
    __swig_getmethods__["last_index"] = _playerc.playerc_audio_last_index_get
    if _newclass:last_index = property(_playerc.playerc_audio_last_index_get, _playerc.playerc_audio_last_index_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_audio(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_audio_destroy(*args)
    def subscribe(*args): return _playerc.playerc_audio_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_audio_unsubscribe(*args)
    def wav_play_cmd(*args): return _playerc.playerc_audio_wav_play_cmd(*args)
    def wav_stream_rec_cmd(*args): return _playerc.playerc_audio_wav_stream_rec_cmd(*args)
    def sample_play_cmd(*args): return _playerc.playerc_audio_sample_play_cmd(*args)
    def seq_play_cmd(*args): return _playerc.playerc_audio_seq_play_cmd(*args)
    def mixer_multchannels_cmd(*args): return _playerc.playerc_audio_mixer_multchannels_cmd(*args)
    def mixer_channel_cmd(*args): return _playerc.playerc_audio_mixer_channel_cmd(*args)
    def wav_rec(*args): return _playerc.playerc_audio_wav_rec(*args)
    def sample_load(*args): return _playerc.playerc_audio_sample_load(*args)
    def sample_retrieve(*args): return _playerc.playerc_audio_sample_retrieve(*args)
    def sample_rec(*args): return _playerc.playerc_audio_sample_rec(*args)
    def get_mixer_levels(*args): return _playerc.playerc_audio_get_mixer_levels(*args)
    def get_mixer_details(*args): return _playerc.playerc_audio_get_mixer_details(*args)
    __swig_destroy__ = _playerc.delete_playerc_audio
    __del__ = lambda self : None;
playerc_audio_swigregister = _playerc.playerc_audio_swigregister
playerc_audio_swigregister(playerc_audio)

PLAYERC_BLACKBOARD_DATA_TYPE_NONE = _playerc.PLAYERC_BLACKBOARD_DATA_TYPE_NONE
PLAYERC_BLACKBOARD_DATA_TYPE_SIMPLE = _playerc.PLAYERC_BLACKBOARD_DATA_TYPE_SIMPLE
PLAYERC_BLACKBOARD_DATA_TYPE_COMPLEX = _playerc.PLAYERC_BLACKBOARD_DATA_TYPE_COMPLEX
PLAYERC_BLACKBOARD_DATA_SUBTYPE_NONE = _playerc.PLAYERC_BLACKBOARD_DATA_SUBTYPE_NONE
PLAYERC_BLACKBOARD_DATA_SUBTYPE_STRING = _playerc.PLAYERC_BLACKBOARD_DATA_SUBTYPE_STRING
PLAYERC_BLACKBOARD_DATA_SUBTYPE_INT = _playerc.PLAYERC_BLACKBOARD_DATA_SUBTYPE_INT
PLAYERC_BLACKBOARD_DATA_SUBTYPE_DOUBLE = _playerc.PLAYERC_BLACKBOARD_DATA_SUBTYPE_DOUBLE
class playerc_blackboard(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_blackboard, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_blackboard, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_blackboard_info_set
    __swig_getmethods__["info"] = _playerc.playerc_blackboard_info_get
    if _newclass:info = property(_playerc.playerc_blackboard_info_get, _playerc.playerc_blackboard_info_set)
    __swig_setmethods__["on_blackboard_event"] = _playerc.playerc_blackboard_on_blackboard_event_set
    __swig_getmethods__["on_blackboard_event"] = _playerc.playerc_blackboard_on_blackboard_event_get
    if _newclass:on_blackboard_event = property(_playerc.playerc_blackboard_on_blackboard_event_get, _playerc.playerc_blackboard_on_blackboard_event_set)
    __swig_setmethods__["py_private"] = _playerc.playerc_blackboard_py_private_set
    __swig_getmethods__["py_private"] = _playerc.playerc_blackboard_py_private_get
    if _newclass:py_private = property(_playerc.playerc_blackboard_py_private_get, _playerc.playerc_blackboard_py_private_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_blackboard(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_blackboard_destroy(*args)
    def subscribe(*args): return _playerc.playerc_blackboard_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_blackboard_unsubscribe(*args)
    def subscribe_to_key(*args): return _playerc.playerc_blackboard_subscribe_to_key(*args)
    def get_entry(*args): return _playerc.playerc_blackboard_get_entry(*args)
    def unsubscribe_from_key(*args): return _playerc.playerc_blackboard_unsubscribe_from_key(*args)
    def subscribe_to_group(*args): return _playerc.playerc_blackboard_subscribe_to_group(*args)
    def unsubscribe_from_group(*args): return _playerc.playerc_blackboard_unsubscribe_from_group(*args)
    def set_entry(*args): return _playerc.playerc_blackboard_set_entry(*args)
    def set_string(*args): return _playerc.playerc_blackboard_set_string(*args)
    def set_int(*args): return _playerc.playerc_blackboard_set_int(*args)
    def set_double(*args): return _playerc.playerc_blackboard_set_double(*args)
    def __convert_blackboard_entry__(*args): return _playerc.playerc_blackboard___convert_blackboard_entry__(*args)
    def __set_nested_dictionary_entry__(*args): return _playerc.playerc_blackboard___set_nested_dictionary_entry__(*args)
    def __increment_reference_count__(*args): return _playerc.playerc_blackboard___increment_reference_count__(*args)
    __swig_getmethods__["__python_on_blackboard_event__"] = lambda x: _playerc.playerc_blackboard___python_on_blackboard_event__
    if _newclass:__python_on_blackboard_event__ = staticmethod(_playerc.playerc_blackboard___python_on_blackboard_event__)
    def GetEvents(*args):
        """GetEvents(self) -> PyObject"""
        return _playerc.playerc_blackboard_GetEvents(*args)

    def GetDict(*args):
        """GetDict(self) -> PyObject"""
        return _playerc.playerc_blackboard_GetDict(*args)

    def SetQueueEvents(*args):
        """SetQueueEvents(self, PyObject boolean) -> PyObject"""
        return _playerc.playerc_blackboard_SetQueueEvents(*args)

    def Subscribe(*args):
        """Subscribe(self, int access) -> PyObject"""
        return _playerc.playerc_blackboard_Subscribe(*args)

    def Unsubscribe(*args):
        """Unsubscribe(self) -> PyObject"""
        return _playerc.playerc_blackboard_Unsubscribe(*args)

    def SetString(*args):
        """SetString(self, char key, char group, char value) -> PyObject"""
        return _playerc.playerc_blackboard_SetString(*args)

    def SetInt(*args):
        """SetInt(self, char key, char group, int value) -> PyObject"""
        return _playerc.playerc_blackboard_SetInt(*args)

    def SetDouble(*args):
        """SetDouble(self, char key, char group, double value) -> PyObject"""
        return _playerc.playerc_blackboard_SetDouble(*args)

    def UnsubscribeFromKey(*args):
        """UnsubscribeFromKey(self, char key, char group) -> int"""
        return _playerc.playerc_blackboard_UnsubscribeFromKey(*args)

    def SubscribeToKey(*args):
        """SubscribeToKey(self, char key, char group) -> PyObject"""
        return _playerc.playerc_blackboard_SubscribeToKey(*args)

    def UnsubscribeFromGroup(*args):
        """UnsubscribeFromGroup(self, char group) -> int"""
        return _playerc.playerc_blackboard_UnsubscribeFromGroup(*args)

    def SubscribeToGroup(*args):
        """SubscribeToGroup(self, char group) -> int"""
        return _playerc.playerc_blackboard_SubscribeToGroup(*args)

    def GetEntry(*args):
        """GetEntry(self, char key, char group) -> PyObject"""
        return _playerc.playerc_blackboard_GetEntry(*args)

    def SetEntryRaw(*args):
        """SetEntryRaw(self,  entry) -> PyObject"""
        return _playerc.playerc_blackboard_SetEntryRaw(*args)

    def SetEntry(*args):
        """SetEntry(self, PyObject dict) -> PyObject"""
        return _playerc.playerc_blackboard_SetEntry(*args)

    __swig_destroy__ = _playerc.delete_playerc_blackboard
    __del__ = lambda self : None;
playerc_blackboard_swigregister = _playerc.playerc_blackboard_swigregister
playerc_blackboard_swigregister(playerc_blackboard)
DICT_GROUPS_INDEX = _playerc.DICT_GROUPS_INDEX
DICT_SUBSCRIPTION_DATA_INDEX = _playerc.DICT_SUBSCRIPTION_DATA_INDEX
LIST_EVENTS_INDEX = _playerc.LIST_EVENTS_INDEX
BOOL_QUEUE_EVENTS_INDEX = _playerc.BOOL_QUEUE_EVENTS_INDEX
playerc_blackboard___python_on_blackboard_event__ = _playerc.playerc_blackboard___python_on_blackboard_event__

class playerc_blinkenlight(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_blinkenlight, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_blinkenlight, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_blinkenlight_info_set
    __swig_getmethods__["info"] = _playerc.playerc_blinkenlight_info_get
    if _newclass:info = property(_playerc.playerc_blinkenlight_info_get, _playerc.playerc_blinkenlight_info_set)
    __swig_setmethods__["enabled"] = _playerc.playerc_blinkenlight_enabled_set
    __swig_getmethods__["enabled"] = _playerc.playerc_blinkenlight_enabled_get
    if _newclass:enabled = property(_playerc.playerc_blinkenlight_enabled_get, _playerc.playerc_blinkenlight_enabled_set)
    __swig_setmethods__["duty_cycle"] = _playerc.playerc_blinkenlight_duty_cycle_set
    __swig_getmethods__["duty_cycle"] = _playerc.playerc_blinkenlight_duty_cycle_get
    if _newclass:duty_cycle = property(_playerc.playerc_blinkenlight_duty_cycle_get, _playerc.playerc_blinkenlight_duty_cycle_set)
    __swig_setmethods__["period"] = _playerc.playerc_blinkenlight_period_set
    __swig_getmethods__["period"] = _playerc.playerc_blinkenlight_period_get
    if _newclass:period = property(_playerc.playerc_blinkenlight_period_get, _playerc.playerc_blinkenlight_period_set)
    __swig_setmethods__["red"] = _playerc.playerc_blinkenlight_red_set
    __swig_getmethods__["red"] = _playerc.playerc_blinkenlight_red_get
    if _newclass:red = property(_playerc.playerc_blinkenlight_red_get, _playerc.playerc_blinkenlight_red_set)
    __swig_setmethods__["green"] = _playerc.playerc_blinkenlight_green_set
    __swig_getmethods__["green"] = _playerc.playerc_blinkenlight_green_get
    if _newclass:green = property(_playerc.playerc_blinkenlight_green_get, _playerc.playerc_blinkenlight_green_set)
    __swig_setmethods__["blue"] = _playerc.playerc_blinkenlight_blue_set
    __swig_getmethods__["blue"] = _playerc.playerc_blinkenlight_blue_get
    if _newclass:blue = property(_playerc.playerc_blinkenlight_blue_get, _playerc.playerc_blinkenlight_blue_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_blinkenlight(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_blinkenlight_destroy(*args)
    def subscribe(*args): return _playerc.playerc_blinkenlight_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_blinkenlight_unsubscribe(*args)
    def enable(*args): return _playerc.playerc_blinkenlight_enable(*args)
    def color(*args): return _playerc.playerc_blinkenlight_color(*args)
    def blink(*args): return _playerc.playerc_blinkenlight_blink(*args)
    __swig_destroy__ = _playerc.delete_playerc_blinkenlight
    __del__ = lambda self : None;
playerc_blinkenlight_swigregister = _playerc.playerc_blinkenlight_swigregister
playerc_blinkenlight_swigregister(playerc_blinkenlight)

class playerc_blobfinder(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_blobfinder, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_blobfinder, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_blobfinder_info_set
    __swig_getmethods__["info"] = _playerc.playerc_blobfinder_info_get
    if _newclass:info = property(_playerc.playerc_blobfinder_info_get, _playerc.playerc_blobfinder_info_set)
    __swig_setmethods__["width"] = _playerc.playerc_blobfinder_width_set
    __swig_getmethods__["width"] = _playerc.playerc_blobfinder_width_get
    if _newclass:width = property(_playerc.playerc_blobfinder_width_get, _playerc.playerc_blobfinder_width_set)
    __swig_setmethods__["height"] = _playerc.playerc_blobfinder_height_set
    __swig_getmethods__["height"] = _playerc.playerc_blobfinder_height_get
    if _newclass:height = property(_playerc.playerc_blobfinder_height_get, _playerc.playerc_blobfinder_height_set)
    __swig_setmethods__["blobs_count"] = _playerc.playerc_blobfinder_blobs_count_set
    __swig_getmethods__["blobs_count"] = _playerc.playerc_blobfinder_blobs_count_get
    if _newclass:blobs_count = property(_playerc.playerc_blobfinder_blobs_count_get, _playerc.playerc_blobfinder_blobs_count_set)
    __swig_setmethods__["blobs"] = _playerc.playerc_blobfinder_blobs_set
    __swig_getmethods__["blobs"] = _playerc.playerc_blobfinder_blobs_get
    if _newclass:blobs = property(_playerc.playerc_blobfinder_blobs_get, _playerc.playerc_blobfinder_blobs_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_blobfinder(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_blobfinder_destroy(*args)
    def subscribe(*args): return _playerc.playerc_blobfinder_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_blobfinder_unsubscribe(*args)
    __swig_destroy__ = _playerc.delete_playerc_blobfinder
    __del__ = lambda self : None;
playerc_blobfinder_swigregister = _playerc.playerc_blobfinder_swigregister
playerc_blobfinder_swigregister(playerc_blobfinder)

class playerc_bumper(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_bumper, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_bumper, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_bumper_info_set
    __swig_getmethods__["info"] = _playerc.playerc_bumper_info_get
    if _newclass:info = property(_playerc.playerc_bumper_info_get, _playerc.playerc_bumper_info_set)
    __swig_setmethods__["pose_count"] = _playerc.playerc_bumper_pose_count_set
    __swig_getmethods__["pose_count"] = _playerc.playerc_bumper_pose_count_get
    if _newclass:pose_count = property(_playerc.playerc_bumper_pose_count_get, _playerc.playerc_bumper_pose_count_set)
    __swig_setmethods__["poses"] = _playerc.playerc_bumper_poses_set
    __swig_getmethods__["poses"] = _playerc.playerc_bumper_poses_get
    if _newclass:poses = property(_playerc.playerc_bumper_poses_get, _playerc.playerc_bumper_poses_set)
    __swig_setmethods__["bumper_count"] = _playerc.playerc_bumper_bumper_count_set
    __swig_getmethods__["bumper_count"] = _playerc.playerc_bumper_bumper_count_get
    if _newclass:bumper_count = property(_playerc.playerc_bumper_bumper_count_get, _playerc.playerc_bumper_bumper_count_set)
    __swig_setmethods__["bumpers"] = _playerc.playerc_bumper_bumpers_set
    __swig_getmethods__["bumpers"] = _playerc.playerc_bumper_bumpers_get
    if _newclass:bumpers = property(_playerc.playerc_bumper_bumpers_get, _playerc.playerc_bumper_bumpers_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_bumper(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_bumper_destroy(*args)
    def subscribe(*args): return _playerc.playerc_bumper_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_bumper_unsubscribe(*args)
    def get_geom(*args): return _playerc.playerc_bumper_get_geom(*args)
    __swig_destroy__ = _playerc.delete_playerc_bumper
    __del__ = lambda self : None;
playerc_bumper_swigregister = _playerc.playerc_bumper_swigregister
playerc_bumper_swigregister(playerc_bumper)

class playerc_camera(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_camera, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_camera, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_camera_info_set
    __swig_getmethods__["info"] = _playerc.playerc_camera_info_get
    if _newclass:info = property(_playerc.playerc_camera_info_get, _playerc.playerc_camera_info_set)
    __swig_setmethods__["width"] = _playerc.playerc_camera_width_set
    __swig_getmethods__["width"] = _playerc.playerc_camera_width_get
    if _newclass:width = property(_playerc.playerc_camera_width_get, _playerc.playerc_camera_width_set)
    __swig_setmethods__["height"] = _playerc.playerc_camera_height_set
    __swig_getmethods__["height"] = _playerc.playerc_camera_height_get
    if _newclass:height = property(_playerc.playerc_camera_height_get, _playerc.playerc_camera_height_set)
    __swig_setmethods__["bpp"] = _playerc.playerc_camera_bpp_set
    __swig_getmethods__["bpp"] = _playerc.playerc_camera_bpp_get
    if _newclass:bpp = property(_playerc.playerc_camera_bpp_get, _playerc.playerc_camera_bpp_set)
    __swig_setmethods__["format"] = _playerc.playerc_camera_format_set
    __swig_getmethods__["format"] = _playerc.playerc_camera_format_get
    if _newclass:format = property(_playerc.playerc_camera_format_get, _playerc.playerc_camera_format_set)
    __swig_setmethods__["fdiv"] = _playerc.playerc_camera_fdiv_set
    __swig_getmethods__["fdiv"] = _playerc.playerc_camera_fdiv_get
    if _newclass:fdiv = property(_playerc.playerc_camera_fdiv_get, _playerc.playerc_camera_fdiv_set)
    __swig_setmethods__["compression"] = _playerc.playerc_camera_compression_set
    __swig_getmethods__["compression"] = _playerc.playerc_camera_compression_get
    if _newclass:compression = property(_playerc.playerc_camera_compression_get, _playerc.playerc_camera_compression_set)
    __swig_setmethods__["image_count"] = _playerc.playerc_camera_image_count_set
    __swig_getmethods__["image_count"] = _playerc.playerc_camera_image_count_get
    if _newclass:image_count = property(_playerc.playerc_camera_image_count_get, _playerc.playerc_camera_image_count_set)
    __swig_setmethods__["image"] = _playerc.playerc_camera_image_set
    __swig_getmethods__["image"] = _playerc.playerc_camera_image_get
    if _newclass:image = property(_playerc.playerc_camera_image_get, _playerc.playerc_camera_image_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_camera(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_camera_destroy(*args)
    def subscribe(*args): return _playerc.playerc_camera_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_camera_unsubscribe(*args)
    def decompress(*args): return _playerc.playerc_camera_decompress(*args)
    def save(*args): return _playerc.playerc_camera_save(*args)
    __swig_destroy__ = _playerc.delete_playerc_camera
    __del__ = lambda self : None;
playerc_camera_swigregister = _playerc.playerc_camera_swigregister
playerc_camera_swigregister(playerc_camera)

class playerc_dio(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_dio, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_dio, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_dio_info_set
    __swig_getmethods__["info"] = _playerc.playerc_dio_info_get
    if _newclass:info = property(_playerc.playerc_dio_info_get, _playerc.playerc_dio_info_set)
    __swig_setmethods__["count"] = _playerc.playerc_dio_count_set
    __swig_getmethods__["count"] = _playerc.playerc_dio_count_get
    if _newclass:count = property(_playerc.playerc_dio_count_get, _playerc.playerc_dio_count_set)
    __swig_setmethods__["digin"] = _playerc.playerc_dio_digin_set
    __swig_getmethods__["digin"] = _playerc.playerc_dio_digin_get
    if _newclass:digin = property(_playerc.playerc_dio_digin_get, _playerc.playerc_dio_digin_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_dio(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_dio_destroy(*args)
    def subscribe(*args): return _playerc.playerc_dio_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_dio_unsubscribe(*args)
    def set_output(*args): return _playerc.playerc_dio_set_output(*args)
    __swig_destroy__ = _playerc.delete_playerc_dio
    __del__ = lambda self : None;
playerc_dio_swigregister = _playerc.playerc_dio_swigregister
playerc_dio_swigregister(playerc_dio)

class playerc_fiducial(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_fiducial, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_fiducial, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_fiducial_info_set
    __swig_getmethods__["info"] = _playerc.playerc_fiducial_info_get
    if _newclass:info = property(_playerc.playerc_fiducial_info_get, _playerc.playerc_fiducial_info_set)
    __swig_setmethods__["fiducial_geom"] = _playerc.playerc_fiducial_fiducial_geom_set
    __swig_getmethods__["fiducial_geom"] = _playerc.playerc_fiducial_fiducial_geom_get
    if _newclass:fiducial_geom = property(_playerc.playerc_fiducial_fiducial_geom_get, _playerc.playerc_fiducial_fiducial_geom_set)
    __swig_setmethods__["fiducials_count"] = _playerc.playerc_fiducial_fiducials_count_set
    __swig_getmethods__["fiducials_count"] = _playerc.playerc_fiducial_fiducials_count_get
    if _newclass:fiducials_count = property(_playerc.playerc_fiducial_fiducials_count_get, _playerc.playerc_fiducial_fiducials_count_set)
    __swig_setmethods__["fiducials"] = _playerc.playerc_fiducial_fiducials_set
    __swig_getmethods__["fiducials"] = _playerc.playerc_fiducial_fiducials_get
    if _newclass:fiducials = property(_playerc.playerc_fiducial_fiducials_get, _playerc.playerc_fiducial_fiducials_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_fiducial(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_fiducial_destroy(*args)
    def subscribe(*args): return _playerc.playerc_fiducial_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_fiducial_unsubscribe(*args)
    def get_geom(*args): return _playerc.playerc_fiducial_get_geom(*args)
    __swig_destroy__ = _playerc.delete_playerc_fiducial
    __del__ = lambda self : None;
playerc_fiducial_swigregister = _playerc.playerc_fiducial_swigregister
playerc_fiducial_swigregister(playerc_fiducial)

class playerc_gps(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_gps, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_gps, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_gps_info_set
    __swig_getmethods__["info"] = _playerc.playerc_gps_info_get
    if _newclass:info = property(_playerc.playerc_gps_info_get, _playerc.playerc_gps_info_set)
    __swig_setmethods__["utc_time"] = _playerc.playerc_gps_utc_time_set
    __swig_getmethods__["utc_time"] = _playerc.playerc_gps_utc_time_get
    if _newclass:utc_time = property(_playerc.playerc_gps_utc_time_get, _playerc.playerc_gps_utc_time_set)
    __swig_setmethods__["lat"] = _playerc.playerc_gps_lat_set
    __swig_getmethods__["lat"] = _playerc.playerc_gps_lat_get
    if _newclass:lat = property(_playerc.playerc_gps_lat_get, _playerc.playerc_gps_lat_set)
    __swig_setmethods__["lon"] = _playerc.playerc_gps_lon_set
    __swig_getmethods__["lon"] = _playerc.playerc_gps_lon_get
    if _newclass:lon = property(_playerc.playerc_gps_lon_get, _playerc.playerc_gps_lon_set)
    __swig_setmethods__["alt"] = _playerc.playerc_gps_alt_set
    __swig_getmethods__["alt"] = _playerc.playerc_gps_alt_get
    if _newclass:alt = property(_playerc.playerc_gps_alt_get, _playerc.playerc_gps_alt_set)
    __swig_setmethods__["utm_e"] = _playerc.playerc_gps_utm_e_set
    __swig_getmethods__["utm_e"] = _playerc.playerc_gps_utm_e_get
    if _newclass:utm_e = property(_playerc.playerc_gps_utm_e_get, _playerc.playerc_gps_utm_e_set)
    __swig_setmethods__["utm_n"] = _playerc.playerc_gps_utm_n_set
    __swig_getmethods__["utm_n"] = _playerc.playerc_gps_utm_n_get
    if _newclass:utm_n = property(_playerc.playerc_gps_utm_n_get, _playerc.playerc_gps_utm_n_set)
    __swig_setmethods__["hdop"] = _playerc.playerc_gps_hdop_set
    __swig_getmethods__["hdop"] = _playerc.playerc_gps_hdop_get
    if _newclass:hdop = property(_playerc.playerc_gps_hdop_get, _playerc.playerc_gps_hdop_set)
    __swig_setmethods__["vdop"] = _playerc.playerc_gps_vdop_set
    __swig_getmethods__["vdop"] = _playerc.playerc_gps_vdop_get
    if _newclass:vdop = property(_playerc.playerc_gps_vdop_get, _playerc.playerc_gps_vdop_set)
    __swig_setmethods__["err_horz"] = _playerc.playerc_gps_err_horz_set
    __swig_getmethods__["err_horz"] = _playerc.playerc_gps_err_horz_get
    if _newclass:err_horz = property(_playerc.playerc_gps_err_horz_get, _playerc.playerc_gps_err_horz_set)
    __swig_setmethods__["err_vert"] = _playerc.playerc_gps_err_vert_set
    __swig_getmethods__["err_vert"] = _playerc.playerc_gps_err_vert_get
    if _newclass:err_vert = property(_playerc.playerc_gps_err_vert_get, _playerc.playerc_gps_err_vert_set)
    __swig_setmethods__["quality"] = _playerc.playerc_gps_quality_set
    __swig_getmethods__["quality"] = _playerc.playerc_gps_quality_get
    if _newclass:quality = property(_playerc.playerc_gps_quality_get, _playerc.playerc_gps_quality_set)
    __swig_setmethods__["sat_count"] = _playerc.playerc_gps_sat_count_set
    __swig_getmethods__["sat_count"] = _playerc.playerc_gps_sat_count_get
    if _newclass:sat_count = property(_playerc.playerc_gps_sat_count_get, _playerc.playerc_gps_sat_count_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_gps(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_gps_destroy(*args)
    def subscribe(*args): return _playerc.playerc_gps_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_gps_unsubscribe(*args)
    __swig_destroy__ = _playerc.delete_playerc_gps
    __del__ = lambda self : None;
playerc_gps_swigregister = _playerc.playerc_gps_swigregister
playerc_gps_swigregister(playerc_gps)

class playerc_graphics2d(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_graphics2d, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_graphics2d, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_graphics2d_info_set
    __swig_getmethods__["info"] = _playerc.playerc_graphics2d_info_get
    if _newclass:info = property(_playerc.playerc_graphics2d_info_get, _playerc.playerc_graphics2d_info_set)
    __swig_setmethods__["color"] = _playerc.playerc_graphics2d_color_set
    __swig_getmethods__["color"] = _playerc.playerc_graphics2d_color_get
    if _newclass:color = property(_playerc.playerc_graphics2d_color_get, _playerc.playerc_graphics2d_color_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_graphics2d(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_graphics2d_destroy(*args)
    def subscribe(*args): return _playerc.playerc_graphics2d_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_graphics2d_unsubscribe(*args)
    def setcolor(*args): return _playerc.playerc_graphics2d_setcolor(*args)
    def draw_points(*args): return _playerc.playerc_graphics2d_draw_points(*args)
    def draw_polyline(*args): return _playerc.playerc_graphics2d_draw_polyline(*args)
    def draw_polygon(*args): return _playerc.playerc_graphics2d_draw_polygon(*args)
    def clear(*args): return _playerc.playerc_graphics2d_clear(*args)
    __swig_destroy__ = _playerc.delete_playerc_graphics2d
    __del__ = lambda self : None;
playerc_graphics2d_swigregister = _playerc.playerc_graphics2d_swigregister
playerc_graphics2d_swigregister(playerc_graphics2d)

class playerc_graphics3d(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_graphics3d, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_graphics3d, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_graphics3d_info_set
    __swig_getmethods__["info"] = _playerc.playerc_graphics3d_info_get
    if _newclass:info = property(_playerc.playerc_graphics3d_info_get, _playerc.playerc_graphics3d_info_set)
    __swig_setmethods__["color"] = _playerc.playerc_graphics3d_color_set
    __swig_getmethods__["color"] = _playerc.playerc_graphics3d_color_get
    if _newclass:color = property(_playerc.playerc_graphics3d_color_get, _playerc.playerc_graphics3d_color_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_graphics3d(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_graphics3d_destroy(*args)
    def subscribe(*args): return _playerc.playerc_graphics3d_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_graphics3d_unsubscribe(*args)
    def setcolor(*args): return _playerc.playerc_graphics3d_setcolor(*args)
    def draw(*args): return _playerc.playerc_graphics3d_draw(*args)
    def clear(*args): return _playerc.playerc_graphics3d_clear(*args)
    def translate(*args): return _playerc.playerc_graphics3d_translate(*args)
    def rotate(*args): return _playerc.playerc_graphics3d_rotate(*args)
    __swig_destroy__ = _playerc.delete_playerc_graphics3d
    __del__ = lambda self : None;
playerc_graphics3d_swigregister = _playerc.playerc_graphics3d_swigregister
playerc_graphics3d_swigregister(playerc_graphics3d)

class playerc_gripper(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_gripper, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_gripper, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_gripper_info_set
    __swig_getmethods__["info"] = _playerc.playerc_gripper_info_get
    if _newclass:info = property(_playerc.playerc_gripper_info_get, _playerc.playerc_gripper_info_set)
    __swig_setmethods__["pose"] = _playerc.playerc_gripper_pose_set
    __swig_getmethods__["pose"] = _playerc.playerc_gripper_pose_get
    if _newclass:pose = property(_playerc.playerc_gripper_pose_get, _playerc.playerc_gripper_pose_set)
    __swig_setmethods__["outer_size"] = _playerc.playerc_gripper_outer_size_set
    __swig_getmethods__["outer_size"] = _playerc.playerc_gripper_outer_size_get
    if _newclass:outer_size = property(_playerc.playerc_gripper_outer_size_get, _playerc.playerc_gripper_outer_size_set)
    __swig_setmethods__["inner_size"] = _playerc.playerc_gripper_inner_size_set
    __swig_getmethods__["inner_size"] = _playerc.playerc_gripper_inner_size_get
    if _newclass:inner_size = property(_playerc.playerc_gripper_inner_size_get, _playerc.playerc_gripper_inner_size_set)
    __swig_setmethods__["num_beams"] = _playerc.playerc_gripper_num_beams_set
    __swig_getmethods__["num_beams"] = _playerc.playerc_gripper_num_beams_get
    if _newclass:num_beams = property(_playerc.playerc_gripper_num_beams_get, _playerc.playerc_gripper_num_beams_set)
    __swig_setmethods__["capacity"] = _playerc.playerc_gripper_capacity_set
    __swig_getmethods__["capacity"] = _playerc.playerc_gripper_capacity_get
    if _newclass:capacity = property(_playerc.playerc_gripper_capacity_get, _playerc.playerc_gripper_capacity_set)
    __swig_setmethods__["state"] = _playerc.playerc_gripper_state_set
    __swig_getmethods__["state"] = _playerc.playerc_gripper_state_get
    if _newclass:state = property(_playerc.playerc_gripper_state_get, _playerc.playerc_gripper_state_set)
    __swig_setmethods__["beams"] = _playerc.playerc_gripper_beams_set
    __swig_getmethods__["beams"] = _playerc.playerc_gripper_beams_get
    if _newclass:beams = property(_playerc.playerc_gripper_beams_get, _playerc.playerc_gripper_beams_set)
    __swig_setmethods__["stored"] = _playerc.playerc_gripper_stored_set
    __swig_getmethods__["stored"] = _playerc.playerc_gripper_stored_get
    if _newclass:stored = property(_playerc.playerc_gripper_stored_get, _playerc.playerc_gripper_stored_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_gripper(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_gripper_destroy(*args)
    def subscribe(*args): return _playerc.playerc_gripper_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_gripper_unsubscribe(*args)
    def open_cmd(*args): return _playerc.playerc_gripper_open_cmd(*args)
    def close_cmd(*args): return _playerc.playerc_gripper_close_cmd(*args)
    def stop_cmd(*args): return _playerc.playerc_gripper_stop_cmd(*args)
    def store_cmd(*args): return _playerc.playerc_gripper_store_cmd(*args)
    def retrieve_cmd(*args): return _playerc.playerc_gripper_retrieve_cmd(*args)
    def printout(*args): return _playerc.playerc_gripper_printout(*args)
    def get_geom(*args): return _playerc.playerc_gripper_get_geom(*args)
    __swig_destroy__ = _playerc.delete_playerc_gripper
    __del__ = lambda self : None;
playerc_gripper_swigregister = _playerc.playerc_gripper_swigregister
playerc_gripper_swigregister(playerc_gripper)

class playerc_health(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_health, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_health, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_health_info_set
    __swig_getmethods__["info"] = _playerc.playerc_health_info_get
    if _newclass:info = property(_playerc.playerc_health_info_get, _playerc.playerc_health_info_set)
    __swig_setmethods__["cpu_usage"] = _playerc.playerc_health_cpu_usage_set
    __swig_getmethods__["cpu_usage"] = _playerc.playerc_health_cpu_usage_get
    if _newclass:cpu_usage = property(_playerc.playerc_health_cpu_usage_get, _playerc.playerc_health_cpu_usage_set)
    __swig_setmethods__["mem"] = _playerc.playerc_health_mem_set
    __swig_getmethods__["mem"] = _playerc.playerc_health_mem_get
    if _newclass:mem = property(_playerc.playerc_health_mem_get, _playerc.playerc_health_mem_set)
    __swig_setmethods__["swap"] = _playerc.playerc_health_swap_set
    __swig_getmethods__["swap"] = _playerc.playerc_health_swap_get
    if _newclass:swap = property(_playerc.playerc_health_swap_get, _playerc.playerc_health_swap_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_health(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_health_destroy(*args)
    def subscribe(*args): return _playerc.playerc_health_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_health_unsubscribe(*args)
    __swig_destroy__ = _playerc.delete_playerc_health
    __del__ = lambda self : None;
playerc_health_swigregister = _playerc.playerc_health_swigregister
playerc_health_swigregister(playerc_health)

class playerc_ir(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_ir, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_ir, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_ir_info_set
    __swig_getmethods__["info"] = _playerc.playerc_ir_info_get
    if _newclass:info = property(_playerc.playerc_ir_info_get, _playerc.playerc_ir_info_set)
    __swig_setmethods__["data"] = _playerc.playerc_ir_data_set
    __swig_getmethods__["data"] = _playerc.playerc_ir_data_get
    if _newclass:data = property(_playerc.playerc_ir_data_get, _playerc.playerc_ir_data_set)
    __swig_setmethods__["poses"] = _playerc.playerc_ir_poses_set
    __swig_getmethods__["poses"] = _playerc.playerc_ir_poses_get
    if _newclass:poses = property(_playerc.playerc_ir_poses_get, _playerc.playerc_ir_poses_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_ir(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_ir_destroy(*args)
    def subscribe(*args): return _playerc.playerc_ir_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_ir_unsubscribe(*args)
    def get_geom(*args): return _playerc.playerc_ir_get_geom(*args)
    __swig_destroy__ = _playerc.delete_playerc_ir
    __del__ = lambda self : None;
playerc_ir_swigregister = _playerc.playerc_ir_swigregister
playerc_ir_swigregister(playerc_ir)

class playerc_joystick(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_joystick, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_joystick, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_joystick_info_set
    __swig_getmethods__["info"] = _playerc.playerc_joystick_info_get
    if _newclass:info = property(_playerc.playerc_joystick_info_get, _playerc.playerc_joystick_info_set)
    __swig_setmethods__["axes_count"] = _playerc.playerc_joystick_axes_count_set
    __swig_getmethods__["axes_count"] = _playerc.playerc_joystick_axes_count_get
    if _newclass:axes_count = property(_playerc.playerc_joystick_axes_count_get, _playerc.playerc_joystick_axes_count_set)
    __swig_setmethods__["pos"] = _playerc.playerc_joystick_pos_set
    __swig_getmethods__["pos"] = _playerc.playerc_joystick_pos_get
    if _newclass:pos = property(_playerc.playerc_joystick_pos_get, _playerc.playerc_joystick_pos_set)
    __swig_setmethods__["buttons"] = _playerc.playerc_joystick_buttons_set
    __swig_getmethods__["buttons"] = _playerc.playerc_joystick_buttons_get
    if _newclass:buttons = property(_playerc.playerc_joystick_buttons_get, _playerc.playerc_joystick_buttons_set)
    __swig_setmethods__["axes_max"] = _playerc.playerc_joystick_axes_max_set
    __swig_getmethods__["axes_max"] = _playerc.playerc_joystick_axes_max_get
    if _newclass:axes_max = property(_playerc.playerc_joystick_axes_max_get, _playerc.playerc_joystick_axes_max_set)
    __swig_setmethods__["axes_min"] = _playerc.playerc_joystick_axes_min_set
    __swig_getmethods__["axes_min"] = _playerc.playerc_joystick_axes_min_get
    if _newclass:axes_min = property(_playerc.playerc_joystick_axes_min_get, _playerc.playerc_joystick_axes_min_set)
    __swig_setmethods__["scale_pos"] = _playerc.playerc_joystick_scale_pos_set
    __swig_getmethods__["scale_pos"] = _playerc.playerc_joystick_scale_pos_get
    if _newclass:scale_pos = property(_playerc.playerc_joystick_scale_pos_get, _playerc.playerc_joystick_scale_pos_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_joystick(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_joystick_destroy(*args)
    def subscribe(*args): return _playerc.playerc_joystick_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_joystick_unsubscribe(*args)
    __swig_destroy__ = _playerc.delete_playerc_joystick
    __del__ = lambda self : None;
playerc_joystick_swigregister = _playerc.playerc_joystick_swigregister
playerc_joystick_swigregister(playerc_joystick)

class playerc_laser(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_laser, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_laser, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_laser_info_set
    __swig_getmethods__["info"] = _playerc.playerc_laser_info_get
    if _newclass:info = property(_playerc.playerc_laser_info_get, _playerc.playerc_laser_info_set)
    __swig_setmethods__["pose"] = _playerc.playerc_laser_pose_set
    __swig_getmethods__["pose"] = _playerc.playerc_laser_pose_get
    if _newclass:pose = property(_playerc.playerc_laser_pose_get, _playerc.playerc_laser_pose_set)
    __swig_setmethods__["size"] = _playerc.playerc_laser_size_set
    __swig_getmethods__["size"] = _playerc.playerc_laser_size_get
    if _newclass:size = property(_playerc.playerc_laser_size_get, _playerc.playerc_laser_size_set)
    __swig_setmethods__["robot_pose"] = _playerc.playerc_laser_robot_pose_set
    __swig_getmethods__["robot_pose"] = _playerc.playerc_laser_robot_pose_get
    if _newclass:robot_pose = property(_playerc.playerc_laser_robot_pose_get, _playerc.playerc_laser_robot_pose_set)
    __swig_setmethods__["intensity_on"] = _playerc.playerc_laser_intensity_on_set
    __swig_getmethods__["intensity_on"] = _playerc.playerc_laser_intensity_on_get
    if _newclass:intensity_on = property(_playerc.playerc_laser_intensity_on_get, _playerc.playerc_laser_intensity_on_set)
    __swig_setmethods__["scan_count"] = _playerc.playerc_laser_scan_count_set
    __swig_getmethods__["scan_count"] = _playerc.playerc_laser_scan_count_get
    if _newclass:scan_count = property(_playerc.playerc_laser_scan_count_get, _playerc.playerc_laser_scan_count_set)
    __swig_setmethods__["scan_start"] = _playerc.playerc_laser_scan_start_set
    __swig_getmethods__["scan_start"] = _playerc.playerc_laser_scan_start_get
    if _newclass:scan_start = property(_playerc.playerc_laser_scan_start_get, _playerc.playerc_laser_scan_start_set)
    __swig_setmethods__["scan_res"] = _playerc.playerc_laser_scan_res_set
    __swig_getmethods__["scan_res"] = _playerc.playerc_laser_scan_res_get
    if _newclass:scan_res = property(_playerc.playerc_laser_scan_res_get, _playerc.playerc_laser_scan_res_set)
    __swig_setmethods__["range_res"] = _playerc.playerc_laser_range_res_set
    __swig_getmethods__["range_res"] = _playerc.playerc_laser_range_res_get
    if _newclass:range_res = property(_playerc.playerc_laser_range_res_get, _playerc.playerc_laser_range_res_set)
    __swig_setmethods__["max_range"] = _playerc.playerc_laser_max_range_set
    __swig_getmethods__["max_range"] = _playerc.playerc_laser_max_range_get
    if _newclass:max_range = property(_playerc.playerc_laser_max_range_get, _playerc.playerc_laser_max_range_set)
    __swig_setmethods__["scanning_frequency"] = _playerc.playerc_laser_scanning_frequency_set
    __swig_getmethods__["scanning_frequency"] = _playerc.playerc_laser_scanning_frequency_get
    if _newclass:scanning_frequency = property(_playerc.playerc_laser_scanning_frequency_get, _playerc.playerc_laser_scanning_frequency_set)
    __swig_setmethods__["ranges"] = _playerc.playerc_laser_ranges_set
    __swig_getmethods__["ranges"] = _playerc.playerc_laser_ranges_get
    if _newclass:ranges = property(_playerc.playerc_laser_ranges_get, _playerc.playerc_laser_ranges_set)
    __swig_setmethods__["scan"] = _playerc.playerc_laser_scan_set
    __swig_getmethods__["scan"] = _playerc.playerc_laser_scan_get
    if _newclass:scan = property(_playerc.playerc_laser_scan_get, _playerc.playerc_laser_scan_set)
    __swig_setmethods__["point"] = _playerc.playerc_laser_point_set
    __swig_getmethods__["point"] = _playerc.playerc_laser_point_get
    if _newclass:point = property(_playerc.playerc_laser_point_get, _playerc.playerc_laser_point_set)
    __swig_setmethods__["intensity"] = _playerc.playerc_laser_intensity_set
    __swig_getmethods__["intensity"] = _playerc.playerc_laser_intensity_get
    if _newclass:intensity = property(_playerc.playerc_laser_intensity_get, _playerc.playerc_laser_intensity_set)
    __swig_setmethods__["scan_id"] = _playerc.playerc_laser_scan_id_set
    __swig_getmethods__["scan_id"] = _playerc.playerc_laser_scan_id_get
    if _newclass:scan_id = property(_playerc.playerc_laser_scan_id_get, _playerc.playerc_laser_scan_id_set)
    __swig_setmethods__["laser_id"] = _playerc.playerc_laser_laser_id_set
    __swig_getmethods__["laser_id"] = _playerc.playerc_laser_laser_id_get
    if _newclass:laser_id = property(_playerc.playerc_laser_laser_id_get, _playerc.playerc_laser_laser_id_set)
    __swig_setmethods__["min_right"] = _playerc.playerc_laser_min_right_set
    __swig_getmethods__["min_right"] = _playerc.playerc_laser_min_right_get
    if _newclass:min_right = property(_playerc.playerc_laser_min_right_get, _playerc.playerc_laser_min_right_set)
    __swig_setmethods__["min_left"] = _playerc.playerc_laser_min_left_set
    __swig_getmethods__["min_left"] = _playerc.playerc_laser_min_left_get
    if _newclass:min_left = property(_playerc.playerc_laser_min_left_get, _playerc.playerc_laser_min_left_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_laser(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_laser_destroy(*args)
    def subscribe(*args): return _playerc.playerc_laser_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_laser_unsubscribe(*args)
    def set_config(*args): return _playerc.playerc_laser_set_config(*args)
    def get_config(*args): return _playerc.playerc_laser_get_config(*args)
    def get_geom(*args): return _playerc.playerc_laser_get_geom(*args)
    def get_id(*args): return _playerc.playerc_laser_get_id(*args)
    def printout(*args): return _playerc.playerc_laser_printout(*args)
    __swig_destroy__ = _playerc.delete_playerc_laser
    __del__ = lambda self : None;
playerc_laser_swigregister = _playerc.playerc_laser_swigregister
playerc_laser_swigregister(playerc_laser)

class playerc_limb(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_limb, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_limb, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_limb_info_set
    __swig_getmethods__["info"] = _playerc.playerc_limb_info_get
    if _newclass:info = property(_playerc.playerc_limb_info_get, _playerc.playerc_limb_info_set)
    __swig_setmethods__["data"] = _playerc.playerc_limb_data_set
    __swig_getmethods__["data"] = _playerc.playerc_limb_data_get
    if _newclass:data = property(_playerc.playerc_limb_data_get, _playerc.playerc_limb_data_set)
    __swig_setmethods__["geom"] = _playerc.playerc_limb_geom_set
    __swig_getmethods__["geom"] = _playerc.playerc_limb_geom_get
    if _newclass:geom = property(_playerc.playerc_limb_geom_get, _playerc.playerc_limb_geom_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_limb(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_limb_destroy(*args)
    def subscribe(*args): return _playerc.playerc_limb_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_limb_unsubscribe(*args)
    def get_geom(*args): return _playerc.playerc_limb_get_geom(*args)
    def home_cmd(*args): return _playerc.playerc_limb_home_cmd(*args)
    def stop_cmd(*args): return _playerc.playerc_limb_stop_cmd(*args)
    def setpose_cmd(*args): return _playerc.playerc_limb_setpose_cmd(*args)
    def setposition_cmd(*args): return _playerc.playerc_limb_setposition_cmd(*args)
    def vecmove_cmd(*args): return _playerc.playerc_limb_vecmove_cmd(*args)
    def power(*args): return _playerc.playerc_limb_power(*args)
    def brakes(*args): return _playerc.playerc_limb_brakes(*args)
    def speed_config(*args): return _playerc.playerc_limb_speed_config(*args)
    __swig_destroy__ = _playerc.delete_playerc_limb
    __del__ = lambda self : None;
playerc_limb_swigregister = _playerc.playerc_limb_swigregister
playerc_limb_swigregister(playerc_limb)

class playerc_localize_particle(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_localize_particle, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_localize_particle, name)
    __repr__ = _swig_repr
    __swig_setmethods__["pose"] = _playerc.playerc_localize_particle_pose_set
    __swig_getmethods__["pose"] = _playerc.playerc_localize_particle_pose_get
    if _newclass:pose = property(_playerc.playerc_localize_particle_pose_get, _playerc.playerc_localize_particle_pose_set)
    __swig_setmethods__["weight"] = _playerc.playerc_localize_particle_weight_set
    __swig_getmethods__["weight"] = _playerc.playerc_localize_particle_weight_get
    if _newclass:weight = property(_playerc.playerc_localize_particle_weight_get, _playerc.playerc_localize_particle_weight_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_localize_particle(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_playerc_localize_particle
    __del__ = lambda self : None;
playerc_localize_particle_swigregister = _playerc.playerc_localize_particle_swigregister
playerc_localize_particle_swigregister(playerc_localize_particle)

class playerc_localize(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_localize, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_localize, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_localize_info_set
    __swig_getmethods__["info"] = _playerc.playerc_localize_info_get
    if _newclass:info = property(_playerc.playerc_localize_info_get, _playerc.playerc_localize_info_set)
    __swig_setmethods__["map_size_x"] = _playerc.playerc_localize_map_size_x_set
    __swig_getmethods__["map_size_x"] = _playerc.playerc_localize_map_size_x_get
    if _newclass:map_size_x = property(_playerc.playerc_localize_map_size_x_get, _playerc.playerc_localize_map_size_x_set)
    __swig_setmethods__["map_size_y"] = _playerc.playerc_localize_map_size_y_set
    __swig_getmethods__["map_size_y"] = _playerc.playerc_localize_map_size_y_get
    if _newclass:map_size_y = property(_playerc.playerc_localize_map_size_y_get, _playerc.playerc_localize_map_size_y_set)
    __swig_setmethods__["map_scale"] = _playerc.playerc_localize_map_scale_set
    __swig_getmethods__["map_scale"] = _playerc.playerc_localize_map_scale_get
    if _newclass:map_scale = property(_playerc.playerc_localize_map_scale_get, _playerc.playerc_localize_map_scale_set)
    __swig_setmethods__["map_tile_x"] = _playerc.playerc_localize_map_tile_x_set
    __swig_getmethods__["map_tile_x"] = _playerc.playerc_localize_map_tile_x_get
    if _newclass:map_tile_x = property(_playerc.playerc_localize_map_tile_x_get, _playerc.playerc_localize_map_tile_x_set)
    __swig_setmethods__["map_tile_y"] = _playerc.playerc_localize_map_tile_y_set
    __swig_getmethods__["map_tile_y"] = _playerc.playerc_localize_map_tile_y_get
    if _newclass:map_tile_y = property(_playerc.playerc_localize_map_tile_y_get, _playerc.playerc_localize_map_tile_y_set)
    __swig_setmethods__["map_cells"] = _playerc.playerc_localize_map_cells_set
    __swig_getmethods__["map_cells"] = _playerc.playerc_localize_map_cells_get
    if _newclass:map_cells = property(_playerc.playerc_localize_map_cells_get, _playerc.playerc_localize_map_cells_set)
    __swig_setmethods__["pending_count"] = _playerc.playerc_localize_pending_count_set
    __swig_getmethods__["pending_count"] = _playerc.playerc_localize_pending_count_get
    if _newclass:pending_count = property(_playerc.playerc_localize_pending_count_get, _playerc.playerc_localize_pending_count_set)
    __swig_setmethods__["pending_time"] = _playerc.playerc_localize_pending_time_set
    __swig_getmethods__["pending_time"] = _playerc.playerc_localize_pending_time_get
    if _newclass:pending_time = property(_playerc.playerc_localize_pending_time_get, _playerc.playerc_localize_pending_time_set)
    __swig_setmethods__["hypoth_count"] = _playerc.playerc_localize_hypoth_count_set
    __swig_getmethods__["hypoth_count"] = _playerc.playerc_localize_hypoth_count_get
    if _newclass:hypoth_count = property(_playerc.playerc_localize_hypoth_count_get, _playerc.playerc_localize_hypoth_count_set)
    __swig_setmethods__["hypoths"] = _playerc.playerc_localize_hypoths_set
    __swig_getmethods__["hypoths"] = _playerc.playerc_localize_hypoths_get
    if _newclass:hypoths = property(_playerc.playerc_localize_hypoths_get, _playerc.playerc_localize_hypoths_set)
    __swig_setmethods__["mean"] = _playerc.playerc_localize_mean_set
    __swig_getmethods__["mean"] = _playerc.playerc_localize_mean_get
    if _newclass:mean = property(_playerc.playerc_localize_mean_get, _playerc.playerc_localize_mean_set)
    __swig_setmethods__["variance"] = _playerc.playerc_localize_variance_set
    __swig_getmethods__["variance"] = _playerc.playerc_localize_variance_get
    if _newclass:variance = property(_playerc.playerc_localize_variance_get, _playerc.playerc_localize_variance_set)
    __swig_setmethods__["num_particles"] = _playerc.playerc_localize_num_particles_set
    __swig_getmethods__["num_particles"] = _playerc.playerc_localize_num_particles_get
    if _newclass:num_particles = property(_playerc.playerc_localize_num_particles_get, _playerc.playerc_localize_num_particles_set)
    __swig_setmethods__["particles"] = _playerc.playerc_localize_particles_set
    __swig_getmethods__["particles"] = _playerc.playerc_localize_particles_get
    if _newclass:particles = property(_playerc.playerc_localize_particles_get, _playerc.playerc_localize_particles_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_localize(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_localize_destroy(*args)
    def subscribe(*args): return _playerc.playerc_localize_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_localize_unsubscribe(*args)
    def set_pose(*args): return _playerc.playerc_localize_set_pose(*args)
    def get_particles(*args): return _playerc.playerc_localize_get_particles(*args)
    __swig_destroy__ = _playerc.delete_playerc_localize
    __del__ = lambda self : None;
playerc_localize_swigregister = _playerc.playerc_localize_swigregister
playerc_localize_swigregister(playerc_localize)

class playerc_log(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_log, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_log, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_log_info_set
    __swig_getmethods__["info"] = _playerc.playerc_log_info_get
    if _newclass:info = property(_playerc.playerc_log_info_get, _playerc.playerc_log_info_set)
    __swig_setmethods__["type"] = _playerc.playerc_log_type_set
    __swig_getmethods__["type"] = _playerc.playerc_log_type_get
    if _newclass:type = property(_playerc.playerc_log_type_get, _playerc.playerc_log_type_set)
    __swig_setmethods__["state"] = _playerc.playerc_log_state_set
    __swig_getmethods__["state"] = _playerc.playerc_log_state_get
    if _newclass:state = property(_playerc.playerc_log_state_get, _playerc.playerc_log_state_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_log(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_log_destroy(*args)
    def subscribe(*args): return _playerc.playerc_log_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_log_unsubscribe(*args)
    def set_write_state(*args): return _playerc.playerc_log_set_write_state(*args)
    def set_read_state(*args): return _playerc.playerc_log_set_read_state(*args)
    def set_read_rewind(*args): return _playerc.playerc_log_set_read_rewind(*args)
    def get_state(*args): return _playerc.playerc_log_get_state(*args)
    def set_filename(*args): return _playerc.playerc_log_set_filename(*args)
    __swig_destroy__ = _playerc.delete_playerc_log
    __del__ = lambda self : None;
playerc_log_swigregister = _playerc.playerc_log_swigregister
playerc_log_swigregister(playerc_log)

class playerc_map(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_map, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_map, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_map_info_set
    __swig_getmethods__["info"] = _playerc.playerc_map_info_get
    if _newclass:info = property(_playerc.playerc_map_info_get, _playerc.playerc_map_info_set)
    __swig_setmethods__["resolution"] = _playerc.playerc_map_resolution_set
    __swig_getmethods__["resolution"] = _playerc.playerc_map_resolution_get
    if _newclass:resolution = property(_playerc.playerc_map_resolution_get, _playerc.playerc_map_resolution_set)
    __swig_setmethods__["width"] = _playerc.playerc_map_width_set
    __swig_getmethods__["width"] = _playerc.playerc_map_width_get
    if _newclass:width = property(_playerc.playerc_map_width_get, _playerc.playerc_map_width_set)
    __swig_setmethods__["height"] = _playerc.playerc_map_height_set
    __swig_getmethods__["height"] = _playerc.playerc_map_height_get
    if _newclass:height = property(_playerc.playerc_map_height_get, _playerc.playerc_map_height_set)
    __swig_setmethods__["origin"] = _playerc.playerc_map_origin_set
    __swig_getmethods__["origin"] = _playerc.playerc_map_origin_get
    if _newclass:origin = property(_playerc.playerc_map_origin_get, _playerc.playerc_map_origin_set)
    __swig_setmethods__["cells"] = _playerc.playerc_map_cells_set
    __swig_getmethods__["cells"] = _playerc.playerc_map_cells_get
    if _newclass:cells = property(_playerc.playerc_map_cells_get, _playerc.playerc_map_cells_set)
    __swig_setmethods__["vminx"] = _playerc.playerc_map_vminx_set
    __swig_getmethods__["vminx"] = _playerc.playerc_map_vminx_get
    if _newclass:vminx = property(_playerc.playerc_map_vminx_get, _playerc.playerc_map_vminx_set)
    __swig_setmethods__["vminy"] = _playerc.playerc_map_vminy_set
    __swig_getmethods__["vminy"] = _playerc.playerc_map_vminy_get
    if _newclass:vminy = property(_playerc.playerc_map_vminy_get, _playerc.playerc_map_vminy_set)
    __swig_setmethods__["vmaxx"] = _playerc.playerc_map_vmaxx_set
    __swig_getmethods__["vmaxx"] = _playerc.playerc_map_vmaxx_get
    if _newclass:vmaxx = property(_playerc.playerc_map_vmaxx_get, _playerc.playerc_map_vmaxx_set)
    __swig_setmethods__["vmaxy"] = _playerc.playerc_map_vmaxy_set
    __swig_getmethods__["vmaxy"] = _playerc.playerc_map_vmaxy_get
    if _newclass:vmaxy = property(_playerc.playerc_map_vmaxy_get, _playerc.playerc_map_vmaxy_set)
    __swig_setmethods__["num_segments"] = _playerc.playerc_map_num_segments_set
    __swig_getmethods__["num_segments"] = _playerc.playerc_map_num_segments_get
    if _newclass:num_segments = property(_playerc.playerc_map_num_segments_get, _playerc.playerc_map_num_segments_set)
    __swig_setmethods__["segments"] = _playerc.playerc_map_segments_set
    __swig_getmethods__["segments"] = _playerc.playerc_map_segments_get
    if _newclass:segments = property(_playerc.playerc_map_segments_get, _playerc.playerc_map_segments_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_map(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_map_destroy(*args)
    def subscribe(*args): return _playerc.playerc_map_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_map_unsubscribe(*args)
    def get_map(*args): return _playerc.playerc_map_get_map(*args)
    def get_vector(*args): return _playerc.playerc_map_get_vector(*args)
    __swig_destroy__ = _playerc.delete_playerc_map
    __del__ = lambda self : None;
playerc_map_swigregister = _playerc.playerc_map_swigregister
playerc_map_swigregister(playerc_map)

class playerc_vectormap(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_vectormap, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_vectormap, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_vectormap_info_set
    __swig_getmethods__["info"] = _playerc.playerc_vectormap_info_get
    if _newclass:info = property(_playerc.playerc_vectormap_info_get, _playerc.playerc_vectormap_info_set)
    __swig_setmethods__["srid"] = _playerc.playerc_vectormap_srid_set
    __swig_getmethods__["srid"] = _playerc.playerc_vectormap_srid_get
    if _newclass:srid = property(_playerc.playerc_vectormap_srid_get, _playerc.playerc_vectormap_srid_set)
    __swig_setmethods__["extent"] = _playerc.playerc_vectormap_extent_set
    __swig_getmethods__["extent"] = _playerc.playerc_vectormap_extent_get
    if _newclass:extent = property(_playerc.playerc_vectormap_extent_get, _playerc.playerc_vectormap_extent_set)
    __swig_setmethods__["layers_count"] = _playerc.playerc_vectormap_layers_count_set
    __swig_getmethods__["layers_count"] = _playerc.playerc_vectormap_layers_count_get
    if _newclass:layers_count = property(_playerc.playerc_vectormap_layers_count_get, _playerc.playerc_vectormap_layers_count_set)
    __swig_setmethods__["layers_data"] = _playerc.playerc_vectormap_layers_data_set
    __swig_getmethods__["layers_data"] = _playerc.playerc_vectormap_layers_data_get
    if _newclass:layers_data = property(_playerc.playerc_vectormap_layers_data_get, _playerc.playerc_vectormap_layers_data_set)
    __swig_setmethods__["layers_info"] = _playerc.playerc_vectormap_layers_info_set
    __swig_getmethods__["layers_info"] = _playerc.playerc_vectormap_layers_info_get
    if _newclass:layers_info = property(_playerc.playerc_vectormap_layers_info_get, _playerc.playerc_vectormap_layers_info_set)
    __swig_setmethods__["wkbprocessor"] = _playerc.playerc_vectormap_wkbprocessor_set
    __swig_getmethods__["wkbprocessor"] = _playerc.playerc_vectormap_wkbprocessor_get
    if _newclass:wkbprocessor = property(_playerc.playerc_vectormap_wkbprocessor_get, _playerc.playerc_vectormap_wkbprocessor_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_vectormap(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_vectormap_destroy(*args)
    def subscribe(*args): return _playerc.playerc_vectormap_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_vectormap_unsubscribe(*args)
    def get_map_info(*args): return _playerc.playerc_vectormap_get_map_info(*args)
    def get_layer_data(*args): return _playerc.playerc_vectormap_get_layer_data(*args)
    def write_layer(*args): return _playerc.playerc_vectormap_write_layer(*args)
    def cleanup(*args): return _playerc.playerc_vectormap_cleanup(*args)
    def get_feature_data(*args): return _playerc.playerc_vectormap_get_feature_data(*args)
    def get_feature_data_count(*args): return _playerc.playerc_vectormap_get_feature_data_count(*args)
    __swig_destroy__ = _playerc.delete_playerc_vectormap
    __del__ = lambda self : None;
playerc_vectormap_swigregister = _playerc.playerc_vectormap_swigregister
playerc_vectormap_swigregister(playerc_vectormap)

class playerc_opaque(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_opaque, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_opaque, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_opaque_info_set
    __swig_getmethods__["info"] = _playerc.playerc_opaque_info_get
    if _newclass:info = property(_playerc.playerc_opaque_info_get, _playerc.playerc_opaque_info_set)
    __swig_setmethods__["data_count"] = _playerc.playerc_opaque_data_count_set
    __swig_getmethods__["data_count"] = _playerc.playerc_opaque_data_count_get
    if _newclass:data_count = property(_playerc.playerc_opaque_data_count_get, _playerc.playerc_opaque_data_count_set)
    __swig_setmethods__["data"] = _playerc.playerc_opaque_data_set
    __swig_getmethods__["data"] = _playerc.playerc_opaque_data_get
    if _newclass:data = property(_playerc.playerc_opaque_data_get, _playerc.playerc_opaque_data_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_opaque(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_opaque_destroy(*args)
    def subscribe(*args): return _playerc.playerc_opaque_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_opaque_unsubscribe(*args)
    def cmd(*args): return _playerc.playerc_opaque_cmd(*args)
    def req(*args): return _playerc.playerc_opaque_req(*args)
    __swig_destroy__ = _playerc.delete_playerc_opaque
    __del__ = lambda self : None;
playerc_opaque_swigregister = _playerc.playerc_opaque_swigregister
playerc_opaque_swigregister(playerc_opaque)

class playerc_planner(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_planner, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_planner, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_planner_info_set
    __swig_getmethods__["info"] = _playerc.playerc_planner_info_get
    if _newclass:info = property(_playerc.playerc_planner_info_get, _playerc.playerc_planner_info_set)
    __swig_setmethods__["path_valid"] = _playerc.playerc_planner_path_valid_set
    __swig_getmethods__["path_valid"] = _playerc.playerc_planner_path_valid_get
    if _newclass:path_valid = property(_playerc.playerc_planner_path_valid_get, _playerc.playerc_planner_path_valid_set)
    __swig_setmethods__["path_done"] = _playerc.playerc_planner_path_done_set
    __swig_getmethods__["path_done"] = _playerc.playerc_planner_path_done_get
    if _newclass:path_done = property(_playerc.playerc_planner_path_done_get, _playerc.playerc_planner_path_done_set)
    __swig_setmethods__["px"] = _playerc.playerc_planner_px_set
    __swig_getmethods__["px"] = _playerc.playerc_planner_px_get
    if _newclass:px = property(_playerc.playerc_planner_px_get, _playerc.playerc_planner_px_set)
    __swig_setmethods__["py"] = _playerc.playerc_planner_py_set
    __swig_getmethods__["py"] = _playerc.playerc_planner_py_get
    if _newclass:py = property(_playerc.playerc_planner_py_get, _playerc.playerc_planner_py_set)
    __swig_setmethods__["pa"] = _playerc.playerc_planner_pa_set
    __swig_getmethods__["pa"] = _playerc.playerc_planner_pa_get
    if _newclass:pa = property(_playerc.playerc_planner_pa_get, _playerc.playerc_planner_pa_set)
    __swig_setmethods__["gx"] = _playerc.playerc_planner_gx_set
    __swig_getmethods__["gx"] = _playerc.playerc_planner_gx_get
    if _newclass:gx = property(_playerc.playerc_planner_gx_get, _playerc.playerc_planner_gx_set)
    __swig_setmethods__["gy"] = _playerc.playerc_planner_gy_set
    __swig_getmethods__["gy"] = _playerc.playerc_planner_gy_get
    if _newclass:gy = property(_playerc.playerc_planner_gy_get, _playerc.playerc_planner_gy_set)
    __swig_setmethods__["ga"] = _playerc.playerc_planner_ga_set
    __swig_getmethods__["ga"] = _playerc.playerc_planner_ga_get
    if _newclass:ga = property(_playerc.playerc_planner_ga_get, _playerc.playerc_planner_ga_set)
    __swig_setmethods__["wx"] = _playerc.playerc_planner_wx_set
    __swig_getmethods__["wx"] = _playerc.playerc_planner_wx_get
    if _newclass:wx = property(_playerc.playerc_planner_wx_get, _playerc.playerc_planner_wx_set)
    __swig_setmethods__["wy"] = _playerc.playerc_planner_wy_set
    __swig_getmethods__["wy"] = _playerc.playerc_planner_wy_get
    if _newclass:wy = property(_playerc.playerc_planner_wy_get, _playerc.playerc_planner_wy_set)
    __swig_setmethods__["wa"] = _playerc.playerc_planner_wa_set
    __swig_getmethods__["wa"] = _playerc.playerc_planner_wa_get
    if _newclass:wa = property(_playerc.playerc_planner_wa_get, _playerc.playerc_planner_wa_set)
    __swig_setmethods__["curr_waypoint"] = _playerc.playerc_planner_curr_waypoint_set
    __swig_getmethods__["curr_waypoint"] = _playerc.playerc_planner_curr_waypoint_get
    if _newclass:curr_waypoint = property(_playerc.playerc_planner_curr_waypoint_get, _playerc.playerc_planner_curr_waypoint_set)
    __swig_setmethods__["waypoint_count"] = _playerc.playerc_planner_waypoint_count_set
    __swig_getmethods__["waypoint_count"] = _playerc.playerc_planner_waypoint_count_get
    if _newclass:waypoint_count = property(_playerc.playerc_planner_waypoint_count_get, _playerc.playerc_planner_waypoint_count_set)
    __swig_setmethods__["waypoints"] = _playerc.playerc_planner_waypoints_set
    __swig_getmethods__["waypoints"] = _playerc.playerc_planner_waypoints_get
    if _newclass:waypoints = property(_playerc.playerc_planner_waypoints_get, _playerc.playerc_planner_waypoints_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_planner(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_planner_destroy(*args)
    def subscribe(*args): return _playerc.playerc_planner_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_planner_unsubscribe(*args)
    def set_cmd_pose(*args): return _playerc.playerc_planner_set_cmd_pose(*args)
    def get_waypoints(*args): return _playerc.playerc_planner_get_waypoints(*args)
    def enable(*args): return _playerc.playerc_planner_enable(*args)
    __swig_destroy__ = _playerc.delete_playerc_planner
    __del__ = lambda self : None;
playerc_planner_swigregister = _playerc.playerc_planner_swigregister
playerc_planner_swigregister(playerc_planner)

class playerc_position1d(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_position1d, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_position1d, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_position1d_info_set
    __swig_getmethods__["info"] = _playerc.playerc_position1d_info_get
    if _newclass:info = property(_playerc.playerc_position1d_info_get, _playerc.playerc_position1d_info_set)
    __swig_setmethods__["pose"] = _playerc.playerc_position1d_pose_set
    __swig_getmethods__["pose"] = _playerc.playerc_position1d_pose_get
    if _newclass:pose = property(_playerc.playerc_position1d_pose_get, _playerc.playerc_position1d_pose_set)
    __swig_setmethods__["size"] = _playerc.playerc_position1d_size_set
    __swig_getmethods__["size"] = _playerc.playerc_position1d_size_get
    if _newclass:size = property(_playerc.playerc_position1d_size_get, _playerc.playerc_position1d_size_set)
    __swig_setmethods__["pos"] = _playerc.playerc_position1d_pos_set
    __swig_getmethods__["pos"] = _playerc.playerc_position1d_pos_get
    if _newclass:pos = property(_playerc.playerc_position1d_pos_get, _playerc.playerc_position1d_pos_set)
    __swig_setmethods__["vel"] = _playerc.playerc_position1d_vel_set
    __swig_getmethods__["vel"] = _playerc.playerc_position1d_vel_get
    if _newclass:vel = property(_playerc.playerc_position1d_vel_get, _playerc.playerc_position1d_vel_set)
    __swig_setmethods__["stall"] = _playerc.playerc_position1d_stall_set
    __swig_getmethods__["stall"] = _playerc.playerc_position1d_stall_get
    if _newclass:stall = property(_playerc.playerc_position1d_stall_get, _playerc.playerc_position1d_stall_set)
    __swig_setmethods__["status"] = _playerc.playerc_position1d_status_set
    __swig_getmethods__["status"] = _playerc.playerc_position1d_status_get
    if _newclass:status = property(_playerc.playerc_position1d_status_get, _playerc.playerc_position1d_status_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_position1d(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_position1d_destroy(*args)
    def subscribe(*args): return _playerc.playerc_position1d_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_position1d_unsubscribe(*args)
    def enable(*args): return _playerc.playerc_position1d_enable(*args)
    def get_geom(*args): return _playerc.playerc_position1d_get_geom(*args)
    def set_cmd_vel(*args): return _playerc.playerc_position1d_set_cmd_vel(*args)
    def set_cmd_pos(*args): return _playerc.playerc_position1d_set_cmd_pos(*args)
    def set_cmd_pos_with_vel(*args): return _playerc.playerc_position1d_set_cmd_pos_with_vel(*args)
    def set_odom(*args): return _playerc.playerc_position1d_set_odom(*args)
    __swig_destroy__ = _playerc.delete_playerc_position1d
    __del__ = lambda self : None;
playerc_position1d_swigregister = _playerc.playerc_position1d_swigregister
playerc_position1d_swigregister(playerc_position1d)

class playerc_position2d(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_position2d, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_position2d, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_position2d_info_set
    __swig_getmethods__["info"] = _playerc.playerc_position2d_info_get
    if _newclass:info = property(_playerc.playerc_position2d_info_get, _playerc.playerc_position2d_info_set)
    __swig_setmethods__["pose"] = _playerc.playerc_position2d_pose_set
    __swig_getmethods__["pose"] = _playerc.playerc_position2d_pose_get
    if _newclass:pose = property(_playerc.playerc_position2d_pose_get, _playerc.playerc_position2d_pose_set)
    __swig_setmethods__["size"] = _playerc.playerc_position2d_size_set
    __swig_getmethods__["size"] = _playerc.playerc_position2d_size_get
    if _newclass:size = property(_playerc.playerc_position2d_size_get, _playerc.playerc_position2d_size_set)
    __swig_setmethods__["px"] = _playerc.playerc_position2d_px_set
    __swig_getmethods__["px"] = _playerc.playerc_position2d_px_get
    if _newclass:px = property(_playerc.playerc_position2d_px_get, _playerc.playerc_position2d_px_set)
    __swig_setmethods__["py"] = _playerc.playerc_position2d_py_set
    __swig_getmethods__["py"] = _playerc.playerc_position2d_py_get
    if _newclass:py = property(_playerc.playerc_position2d_py_get, _playerc.playerc_position2d_py_set)
    __swig_setmethods__["pa"] = _playerc.playerc_position2d_pa_set
    __swig_getmethods__["pa"] = _playerc.playerc_position2d_pa_get
    if _newclass:pa = property(_playerc.playerc_position2d_pa_get, _playerc.playerc_position2d_pa_set)
    __swig_setmethods__["vx"] = _playerc.playerc_position2d_vx_set
    __swig_getmethods__["vx"] = _playerc.playerc_position2d_vx_get
    if _newclass:vx = property(_playerc.playerc_position2d_vx_get, _playerc.playerc_position2d_vx_set)
    __swig_setmethods__["vy"] = _playerc.playerc_position2d_vy_set
    __swig_getmethods__["vy"] = _playerc.playerc_position2d_vy_get
    if _newclass:vy = property(_playerc.playerc_position2d_vy_get, _playerc.playerc_position2d_vy_set)
    __swig_setmethods__["va"] = _playerc.playerc_position2d_va_set
    __swig_getmethods__["va"] = _playerc.playerc_position2d_va_get
    if _newclass:va = property(_playerc.playerc_position2d_va_get, _playerc.playerc_position2d_va_set)
    __swig_setmethods__["stall"] = _playerc.playerc_position2d_stall_set
    __swig_getmethods__["stall"] = _playerc.playerc_position2d_stall_get
    if _newclass:stall = property(_playerc.playerc_position2d_stall_get, _playerc.playerc_position2d_stall_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_position2d(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_position2d_destroy(*args)
    def subscribe(*args): return _playerc.playerc_position2d_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_position2d_unsubscribe(*args)
    def enable(*args): return _playerc.playerc_position2d_enable(*args)
    def get_geom(*args): return _playerc.playerc_position2d_get_geom(*args)
    def set_cmd_vel(*args): return _playerc.playerc_position2d_set_cmd_vel(*args)
    def set_cmd_pose_with_vel(*args): return _playerc.playerc_position2d_set_cmd_pose_with_vel(*args)
    def set_cmd_vel_head(*args): return _playerc.playerc_position2d_set_cmd_vel_head(*args)
    def set_cmd_pose(*args): return _playerc.playerc_position2d_set_cmd_pose(*args)
    def set_cmd_car(*args): return _playerc.playerc_position2d_set_cmd_car(*args)
    def set_odom(*args): return _playerc.playerc_position2d_set_odom(*args)
    __swig_destroy__ = _playerc.delete_playerc_position2d
    __del__ = lambda self : None;
playerc_position2d_swigregister = _playerc.playerc_position2d_swigregister
playerc_position2d_swigregister(playerc_position2d)

class playerc_position3d(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_position3d, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_position3d, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_position3d_info_set
    __swig_getmethods__["info"] = _playerc.playerc_position3d_info_get
    if _newclass:info = property(_playerc.playerc_position3d_info_get, _playerc.playerc_position3d_info_set)
    __swig_setmethods__["pose"] = _playerc.playerc_position3d_pose_set
    __swig_getmethods__["pose"] = _playerc.playerc_position3d_pose_get
    if _newclass:pose = property(_playerc.playerc_position3d_pose_get, _playerc.playerc_position3d_pose_set)
    __swig_setmethods__["size"] = _playerc.playerc_position3d_size_set
    __swig_getmethods__["size"] = _playerc.playerc_position3d_size_get
    if _newclass:size = property(_playerc.playerc_position3d_size_get, _playerc.playerc_position3d_size_set)
    __swig_setmethods__["pos_x"] = _playerc.playerc_position3d_pos_x_set
    __swig_getmethods__["pos_x"] = _playerc.playerc_position3d_pos_x_get
    if _newclass:pos_x = property(_playerc.playerc_position3d_pos_x_get, _playerc.playerc_position3d_pos_x_set)
    __swig_setmethods__["pos_y"] = _playerc.playerc_position3d_pos_y_set
    __swig_getmethods__["pos_y"] = _playerc.playerc_position3d_pos_y_get
    if _newclass:pos_y = property(_playerc.playerc_position3d_pos_y_get, _playerc.playerc_position3d_pos_y_set)
    __swig_setmethods__["pos_z"] = _playerc.playerc_position3d_pos_z_set
    __swig_getmethods__["pos_z"] = _playerc.playerc_position3d_pos_z_get
    if _newclass:pos_z = property(_playerc.playerc_position3d_pos_z_get, _playerc.playerc_position3d_pos_z_set)
    __swig_setmethods__["pos_roll"] = _playerc.playerc_position3d_pos_roll_set
    __swig_getmethods__["pos_roll"] = _playerc.playerc_position3d_pos_roll_get
    if _newclass:pos_roll = property(_playerc.playerc_position3d_pos_roll_get, _playerc.playerc_position3d_pos_roll_set)
    __swig_setmethods__["pos_pitch"] = _playerc.playerc_position3d_pos_pitch_set
    __swig_getmethods__["pos_pitch"] = _playerc.playerc_position3d_pos_pitch_get
    if _newclass:pos_pitch = property(_playerc.playerc_position3d_pos_pitch_get, _playerc.playerc_position3d_pos_pitch_set)
    __swig_setmethods__["pos_yaw"] = _playerc.playerc_position3d_pos_yaw_set
    __swig_getmethods__["pos_yaw"] = _playerc.playerc_position3d_pos_yaw_get
    if _newclass:pos_yaw = property(_playerc.playerc_position3d_pos_yaw_get, _playerc.playerc_position3d_pos_yaw_set)
    __swig_setmethods__["vel_x"] = _playerc.playerc_position3d_vel_x_set
    __swig_getmethods__["vel_x"] = _playerc.playerc_position3d_vel_x_get
    if _newclass:vel_x = property(_playerc.playerc_position3d_vel_x_get, _playerc.playerc_position3d_vel_x_set)
    __swig_setmethods__["vel_y"] = _playerc.playerc_position3d_vel_y_set
    __swig_getmethods__["vel_y"] = _playerc.playerc_position3d_vel_y_get
    if _newclass:vel_y = property(_playerc.playerc_position3d_vel_y_get, _playerc.playerc_position3d_vel_y_set)
    __swig_setmethods__["vel_z"] = _playerc.playerc_position3d_vel_z_set
    __swig_getmethods__["vel_z"] = _playerc.playerc_position3d_vel_z_get
    if _newclass:vel_z = property(_playerc.playerc_position3d_vel_z_get, _playerc.playerc_position3d_vel_z_set)
    __swig_setmethods__["vel_roll"] = _playerc.playerc_position3d_vel_roll_set
    __swig_getmethods__["vel_roll"] = _playerc.playerc_position3d_vel_roll_get
    if _newclass:vel_roll = property(_playerc.playerc_position3d_vel_roll_get, _playerc.playerc_position3d_vel_roll_set)
    __swig_setmethods__["vel_pitch"] = _playerc.playerc_position3d_vel_pitch_set
    __swig_getmethods__["vel_pitch"] = _playerc.playerc_position3d_vel_pitch_get
    if _newclass:vel_pitch = property(_playerc.playerc_position3d_vel_pitch_get, _playerc.playerc_position3d_vel_pitch_set)
    __swig_setmethods__["vel_yaw"] = _playerc.playerc_position3d_vel_yaw_set
    __swig_getmethods__["vel_yaw"] = _playerc.playerc_position3d_vel_yaw_get
    if _newclass:vel_yaw = property(_playerc.playerc_position3d_vel_yaw_get, _playerc.playerc_position3d_vel_yaw_set)
    __swig_setmethods__["stall"] = _playerc.playerc_position3d_stall_set
    __swig_getmethods__["stall"] = _playerc.playerc_position3d_stall_get
    if _newclass:stall = property(_playerc.playerc_position3d_stall_get, _playerc.playerc_position3d_stall_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_position3d(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_position3d_destroy(*args)
    def subscribe(*args): return _playerc.playerc_position3d_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_position3d_unsubscribe(*args)
    def enable(*args): return _playerc.playerc_position3d_enable(*args)
    def get_geom(*args): return _playerc.playerc_position3d_get_geom(*args)
    def set_velocity(*args): return _playerc.playerc_position3d_set_velocity(*args)
    def set_speed(*args): return _playerc.playerc_position3d_set_speed(*args)
    def set_pose(*args): return _playerc.playerc_position3d_set_pose(*args)
    def set_pose_with_vel(*args): return _playerc.playerc_position3d_set_pose_with_vel(*args)
    def set_cmd_pose(*args): return _playerc.playerc_position3d_set_cmd_pose(*args)
    def set_vel_mode(*args): return _playerc.playerc_position3d_set_vel_mode(*args)
    def set_odom(*args): return _playerc.playerc_position3d_set_odom(*args)
    def reset_odom(*args): return _playerc.playerc_position3d_reset_odom(*args)
    __swig_destroy__ = _playerc.delete_playerc_position3d
    __del__ = lambda self : None;
playerc_position3d_swigregister = _playerc.playerc_position3d_swigregister
playerc_position3d_swigregister(playerc_position3d)

class playerc_power(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_power, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_power, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_power_info_set
    __swig_getmethods__["info"] = _playerc.playerc_power_info_get
    if _newclass:info = property(_playerc.playerc_power_info_get, _playerc.playerc_power_info_set)
    __swig_setmethods__["valid"] = _playerc.playerc_power_valid_set
    __swig_getmethods__["valid"] = _playerc.playerc_power_valid_get
    if _newclass:valid = property(_playerc.playerc_power_valid_get, _playerc.playerc_power_valid_set)
    __swig_setmethods__["charge"] = _playerc.playerc_power_charge_set
    __swig_getmethods__["charge"] = _playerc.playerc_power_charge_get
    if _newclass:charge = property(_playerc.playerc_power_charge_get, _playerc.playerc_power_charge_set)
    __swig_setmethods__["percent"] = _playerc.playerc_power_percent_set
    __swig_getmethods__["percent"] = _playerc.playerc_power_percent_get
    if _newclass:percent = property(_playerc.playerc_power_percent_get, _playerc.playerc_power_percent_set)
    __swig_setmethods__["joules"] = _playerc.playerc_power_joules_set
    __swig_getmethods__["joules"] = _playerc.playerc_power_joules_get
    if _newclass:joules = property(_playerc.playerc_power_joules_get, _playerc.playerc_power_joules_set)
    __swig_setmethods__["watts"] = _playerc.playerc_power_watts_set
    __swig_getmethods__["watts"] = _playerc.playerc_power_watts_get
    if _newclass:watts = property(_playerc.playerc_power_watts_get, _playerc.playerc_power_watts_set)
    __swig_setmethods__["charging"] = _playerc.playerc_power_charging_set
    __swig_getmethods__["charging"] = _playerc.playerc_power_charging_get
    if _newclass:charging = property(_playerc.playerc_power_charging_get, _playerc.playerc_power_charging_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_power(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_power_destroy(*args)
    def subscribe(*args): return _playerc.playerc_power_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_power_unsubscribe(*args)
    __swig_destroy__ = _playerc.delete_playerc_power
    __del__ = lambda self : None;
playerc_power_swigregister = _playerc.playerc_power_swigregister
playerc_power_swigregister(playerc_power)

class playerc_ptz(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_ptz, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_ptz, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_ptz_info_set
    __swig_getmethods__["info"] = _playerc.playerc_ptz_info_get
    if _newclass:info = property(_playerc.playerc_ptz_info_get, _playerc.playerc_ptz_info_set)
    __swig_setmethods__["pan"] = _playerc.playerc_ptz_pan_set
    __swig_getmethods__["pan"] = _playerc.playerc_ptz_pan_get
    if _newclass:pan = property(_playerc.playerc_ptz_pan_get, _playerc.playerc_ptz_pan_set)
    __swig_setmethods__["tilt"] = _playerc.playerc_ptz_tilt_set
    __swig_getmethods__["tilt"] = _playerc.playerc_ptz_tilt_get
    if _newclass:tilt = property(_playerc.playerc_ptz_tilt_get, _playerc.playerc_ptz_tilt_set)
    __swig_setmethods__["zoom"] = _playerc.playerc_ptz_zoom_set
    __swig_getmethods__["zoom"] = _playerc.playerc_ptz_zoom_get
    if _newclass:zoom = property(_playerc.playerc_ptz_zoom_get, _playerc.playerc_ptz_zoom_set)
    __swig_setmethods__["status"] = _playerc.playerc_ptz_status_set
    __swig_getmethods__["status"] = _playerc.playerc_ptz_status_get
    if _newclass:status = property(_playerc.playerc_ptz_status_get, _playerc.playerc_ptz_status_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_ptz(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_ptz_destroy(*args)
    def subscribe(*args): return _playerc.playerc_ptz_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_ptz_unsubscribe(*args)
    def set(*args): return _playerc.playerc_ptz_set(*args)
    def query_status(*args): return _playerc.playerc_ptz_query_status(*args)
    def set_ws(*args): return _playerc.playerc_ptz_set_ws(*args)
    def set_control_mode(*args): return _playerc.playerc_ptz_set_control_mode(*args)
    __swig_destroy__ = _playerc.delete_playerc_ptz
    __del__ = lambda self : None;
playerc_ptz_swigregister = _playerc.playerc_ptz_swigregister
playerc_ptz_swigregister(playerc_ptz)

class playerc_ranger(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_ranger, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_ranger, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_ranger_info_set
    __swig_getmethods__["info"] = _playerc.playerc_ranger_info_get
    if _newclass:info = property(_playerc.playerc_ranger_info_get, _playerc.playerc_ranger_info_set)
    __swig_setmethods__["element_count"] = _playerc.playerc_ranger_element_count_set
    __swig_getmethods__["element_count"] = _playerc.playerc_ranger_element_count_get
    if _newclass:element_count = property(_playerc.playerc_ranger_element_count_get, _playerc.playerc_ranger_element_count_set)
    __swig_setmethods__["min_angle"] = _playerc.playerc_ranger_min_angle_set
    __swig_getmethods__["min_angle"] = _playerc.playerc_ranger_min_angle_get
    if _newclass:min_angle = property(_playerc.playerc_ranger_min_angle_get, _playerc.playerc_ranger_min_angle_set)
    __swig_setmethods__["max_angle"] = _playerc.playerc_ranger_max_angle_set
    __swig_getmethods__["max_angle"] = _playerc.playerc_ranger_max_angle_get
    if _newclass:max_angle = property(_playerc.playerc_ranger_max_angle_get, _playerc.playerc_ranger_max_angle_set)
    __swig_setmethods__["angular_res"] = _playerc.playerc_ranger_angular_res_set
    __swig_getmethods__["angular_res"] = _playerc.playerc_ranger_angular_res_get
    if _newclass:angular_res = property(_playerc.playerc_ranger_angular_res_get, _playerc.playerc_ranger_angular_res_set)
    __swig_setmethods__["min_range"] = _playerc.playerc_ranger_min_range_set
    __swig_getmethods__["min_range"] = _playerc.playerc_ranger_min_range_get
    if _newclass:min_range = property(_playerc.playerc_ranger_min_range_get, _playerc.playerc_ranger_min_range_set)
    __swig_setmethods__["max_range"] = _playerc.playerc_ranger_max_range_set
    __swig_getmethods__["max_range"] = _playerc.playerc_ranger_max_range_get
    if _newclass:max_range = property(_playerc.playerc_ranger_max_range_get, _playerc.playerc_ranger_max_range_set)
    __swig_setmethods__["range_res"] = _playerc.playerc_ranger_range_res_set
    __swig_getmethods__["range_res"] = _playerc.playerc_ranger_range_res_get
    if _newclass:range_res = property(_playerc.playerc_ranger_range_res_get, _playerc.playerc_ranger_range_res_set)
    __swig_setmethods__["frequency"] = _playerc.playerc_ranger_frequency_set
    __swig_getmethods__["frequency"] = _playerc.playerc_ranger_frequency_get
    if _newclass:frequency = property(_playerc.playerc_ranger_frequency_get, _playerc.playerc_ranger_frequency_set)
    __swig_setmethods__["device_pose"] = _playerc.playerc_ranger_device_pose_set
    __swig_getmethods__["device_pose"] = _playerc.playerc_ranger_device_pose_get
    if _newclass:device_pose = property(_playerc.playerc_ranger_device_pose_get, _playerc.playerc_ranger_device_pose_set)
    __swig_setmethods__["device_size"] = _playerc.playerc_ranger_device_size_set
    __swig_getmethods__["device_size"] = _playerc.playerc_ranger_device_size_get
    if _newclass:device_size = property(_playerc.playerc_ranger_device_size_get, _playerc.playerc_ranger_device_size_set)
    __swig_setmethods__["element_poses"] = _playerc.playerc_ranger_element_poses_set
    __swig_getmethods__["element_poses"] = _playerc.playerc_ranger_element_poses_get
    if _newclass:element_poses = property(_playerc.playerc_ranger_element_poses_get, _playerc.playerc_ranger_element_poses_set)
    __swig_setmethods__["element_sizes"] = _playerc.playerc_ranger_element_sizes_set
    __swig_getmethods__["element_sizes"] = _playerc.playerc_ranger_element_sizes_get
    if _newclass:element_sizes = property(_playerc.playerc_ranger_element_sizes_get, _playerc.playerc_ranger_element_sizes_set)
    __swig_setmethods__["ranges_count"] = _playerc.playerc_ranger_ranges_count_set
    __swig_getmethods__["ranges_count"] = _playerc.playerc_ranger_ranges_count_get
    if _newclass:ranges_count = property(_playerc.playerc_ranger_ranges_count_get, _playerc.playerc_ranger_ranges_count_set)
    __swig_setmethods__["ranges"] = _playerc.playerc_ranger_ranges_set
    __swig_getmethods__["ranges"] = _playerc.playerc_ranger_ranges_get
    if _newclass:ranges = property(_playerc.playerc_ranger_ranges_get, _playerc.playerc_ranger_ranges_set)
    __swig_setmethods__["intensities_count"] = _playerc.playerc_ranger_intensities_count_set
    __swig_getmethods__["intensities_count"] = _playerc.playerc_ranger_intensities_count_get
    if _newclass:intensities_count = property(_playerc.playerc_ranger_intensities_count_get, _playerc.playerc_ranger_intensities_count_set)
    __swig_setmethods__["intensities"] = _playerc.playerc_ranger_intensities_set
    __swig_getmethods__["intensities"] = _playerc.playerc_ranger_intensities_get
    if _newclass:intensities = property(_playerc.playerc_ranger_intensities_get, _playerc.playerc_ranger_intensities_set)
    __swig_setmethods__["bearings_count"] = _playerc.playerc_ranger_bearings_count_set
    __swig_getmethods__["bearings_count"] = _playerc.playerc_ranger_bearings_count_get
    if _newclass:bearings_count = property(_playerc.playerc_ranger_bearings_count_get, _playerc.playerc_ranger_bearings_count_set)
    __swig_setmethods__["bearings"] = _playerc.playerc_ranger_bearings_set
    __swig_getmethods__["bearings"] = _playerc.playerc_ranger_bearings_get
    if _newclass:bearings = property(_playerc.playerc_ranger_bearings_get, _playerc.playerc_ranger_bearings_set)
    __swig_setmethods__["points_count"] = _playerc.playerc_ranger_points_count_set
    __swig_getmethods__["points_count"] = _playerc.playerc_ranger_points_count_get
    if _newclass:points_count = property(_playerc.playerc_ranger_points_count_get, _playerc.playerc_ranger_points_count_set)
    __swig_setmethods__["points"] = _playerc.playerc_ranger_points_set
    __swig_getmethods__["points"] = _playerc.playerc_ranger_points_get
    if _newclass:points = property(_playerc.playerc_ranger_points_get, _playerc.playerc_ranger_points_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_ranger(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_ranger_destroy(*args)
    def subscribe(*args): return _playerc.playerc_ranger_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_ranger_unsubscribe(*args)
    def get_geom(*args): return _playerc.playerc_ranger_get_geom(*args)
    def power_config(*args): return _playerc.playerc_ranger_power_config(*args)
    def intns_config(*args): return _playerc.playerc_ranger_intns_config(*args)
    def set_config(*args): return _playerc.playerc_ranger_set_config(*args)
    def get_config(*args): return _playerc.playerc_ranger_get_config(*args)
    __swig_destroy__ = _playerc.delete_playerc_ranger
    __del__ = lambda self : None;
playerc_ranger_swigregister = _playerc.playerc_ranger_swigregister
playerc_ranger_swigregister(playerc_ranger)

class playerc_sonar(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_sonar, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_sonar, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_sonar_info_set
    __swig_getmethods__["info"] = _playerc.playerc_sonar_info_get
    if _newclass:info = property(_playerc.playerc_sonar_info_get, _playerc.playerc_sonar_info_set)
    __swig_setmethods__["pose_count"] = _playerc.playerc_sonar_pose_count_set
    __swig_getmethods__["pose_count"] = _playerc.playerc_sonar_pose_count_get
    if _newclass:pose_count = property(_playerc.playerc_sonar_pose_count_get, _playerc.playerc_sonar_pose_count_set)
    __swig_setmethods__["poses"] = _playerc.playerc_sonar_poses_set
    __swig_getmethods__["poses"] = _playerc.playerc_sonar_poses_get
    if _newclass:poses = property(_playerc.playerc_sonar_poses_get, _playerc.playerc_sonar_poses_set)
    __swig_setmethods__["scan_count"] = _playerc.playerc_sonar_scan_count_set
    __swig_getmethods__["scan_count"] = _playerc.playerc_sonar_scan_count_get
    if _newclass:scan_count = property(_playerc.playerc_sonar_scan_count_get, _playerc.playerc_sonar_scan_count_set)
    __swig_setmethods__["scan"] = _playerc.playerc_sonar_scan_set
    __swig_getmethods__["scan"] = _playerc.playerc_sonar_scan_get
    if _newclass:scan = property(_playerc.playerc_sonar_scan_get, _playerc.playerc_sonar_scan_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_sonar(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_sonar_destroy(*args)
    def subscribe(*args): return _playerc.playerc_sonar_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_sonar_unsubscribe(*args)
    def get_geom(*args): return _playerc.playerc_sonar_get_geom(*args)
    __swig_destroy__ = _playerc.delete_playerc_sonar
    __del__ = lambda self : None;
playerc_sonar_swigregister = _playerc.playerc_sonar_swigregister
playerc_sonar_swigregister(playerc_sonar)

class playerc_wifi_link(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_wifi_link, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_wifi_link, name)
    __repr__ = _swig_repr
    __swig_setmethods__["mac"] = _playerc.playerc_wifi_link_mac_set
    __swig_getmethods__["mac"] = _playerc.playerc_wifi_link_mac_get
    if _newclass:mac = property(_playerc.playerc_wifi_link_mac_get, _playerc.playerc_wifi_link_mac_set)
    __swig_setmethods__["ip"] = _playerc.playerc_wifi_link_ip_set
    __swig_getmethods__["ip"] = _playerc.playerc_wifi_link_ip_get
    if _newclass:ip = property(_playerc.playerc_wifi_link_ip_get, _playerc.playerc_wifi_link_ip_set)
    __swig_setmethods__["essid"] = _playerc.playerc_wifi_link_essid_set
    __swig_getmethods__["essid"] = _playerc.playerc_wifi_link_essid_get
    if _newclass:essid = property(_playerc.playerc_wifi_link_essid_get, _playerc.playerc_wifi_link_essid_set)
    __swig_setmethods__["mode"] = _playerc.playerc_wifi_link_mode_set
    __swig_getmethods__["mode"] = _playerc.playerc_wifi_link_mode_get
    if _newclass:mode = property(_playerc.playerc_wifi_link_mode_get, _playerc.playerc_wifi_link_mode_set)
    __swig_setmethods__["encrypt"] = _playerc.playerc_wifi_link_encrypt_set
    __swig_getmethods__["encrypt"] = _playerc.playerc_wifi_link_encrypt_get
    if _newclass:encrypt = property(_playerc.playerc_wifi_link_encrypt_get, _playerc.playerc_wifi_link_encrypt_set)
    __swig_setmethods__["freq"] = _playerc.playerc_wifi_link_freq_set
    __swig_getmethods__["freq"] = _playerc.playerc_wifi_link_freq_get
    if _newclass:freq = property(_playerc.playerc_wifi_link_freq_get, _playerc.playerc_wifi_link_freq_set)
    __swig_setmethods__["qual"] = _playerc.playerc_wifi_link_qual_set
    __swig_getmethods__["qual"] = _playerc.playerc_wifi_link_qual_get
    if _newclass:qual = property(_playerc.playerc_wifi_link_qual_get, _playerc.playerc_wifi_link_qual_set)
    __swig_setmethods__["level"] = _playerc.playerc_wifi_link_level_set
    __swig_getmethods__["level"] = _playerc.playerc_wifi_link_level_get
    if _newclass:level = property(_playerc.playerc_wifi_link_level_get, _playerc.playerc_wifi_link_level_set)
    __swig_setmethods__["noise"] = _playerc.playerc_wifi_link_noise_set
    __swig_getmethods__["noise"] = _playerc.playerc_wifi_link_noise_get
    if _newclass:noise = property(_playerc.playerc_wifi_link_noise_get, _playerc.playerc_wifi_link_noise_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_wifi_link(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_playerc_wifi_link
    __del__ = lambda self : None;
playerc_wifi_link_swigregister = _playerc.playerc_wifi_link_swigregister
playerc_wifi_link_swigregister(playerc_wifi_link)

class playerc_wifi(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_wifi, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_wifi, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_wifi_info_set
    __swig_getmethods__["info"] = _playerc.playerc_wifi_info_get
    if _newclass:info = property(_playerc.playerc_wifi_info_get, _playerc.playerc_wifi_info_set)
    __swig_setmethods__["links"] = _playerc.playerc_wifi_links_set
    __swig_getmethods__["links"] = _playerc.playerc_wifi_links_get
    if _newclass:links = property(_playerc.playerc_wifi_links_get, _playerc.playerc_wifi_links_set)
    __swig_setmethods__["link_count"] = _playerc.playerc_wifi_link_count_set
    __swig_getmethods__["link_count"] = _playerc.playerc_wifi_link_count_get
    if _newclass:link_count = property(_playerc.playerc_wifi_link_count_get, _playerc.playerc_wifi_link_count_set)
    __swig_setmethods__["ip"] = _playerc.playerc_wifi_ip_set
    __swig_getmethods__["ip"] = _playerc.playerc_wifi_ip_get
    if _newclass:ip = property(_playerc.playerc_wifi_ip_get, _playerc.playerc_wifi_ip_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_wifi(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_wifi_destroy(*args)
    def subscribe(*args): return _playerc.playerc_wifi_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_wifi_unsubscribe(*args)
    def get_link(*args): return _playerc.playerc_wifi_get_link(*args)
    __swig_destroy__ = _playerc.delete_playerc_wifi
    __del__ = lambda self : None;
playerc_wifi_swigregister = _playerc.playerc_wifi_swigregister
playerc_wifi_swigregister(playerc_wifi)

class playerc_simulation(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_simulation, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_simulation, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_simulation_info_set
    __swig_getmethods__["info"] = _playerc.playerc_simulation_info_get
    if _newclass:info = property(_playerc.playerc_simulation_info_get, _playerc.playerc_simulation_info_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_simulation(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_simulation_destroy(*args)
    def subscribe(*args): return _playerc.playerc_simulation_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_simulation_unsubscribe(*args)
    def set_pose2d(*args): return _playerc.playerc_simulation_set_pose2d(*args)
    def get_pose2d(*args): return _playerc.playerc_simulation_get_pose2d(*args)
    def set_pose3d(*args): return _playerc.playerc_simulation_set_pose3d(*args)
    def get_pose3d(*args): return _playerc.playerc_simulation_get_pose3d(*args)
    def set_property(*args): return _playerc.playerc_simulation_set_property(*args)
    def get_property(*args): return _playerc.playerc_simulation_get_property(*args)
    def pause(*args): return _playerc.playerc_simulation_pause(*args)
    def reset(*args): return _playerc.playerc_simulation_reset(*args)
    def save(*args): return _playerc.playerc_simulation_save(*args)
    __swig_destroy__ = _playerc.delete_playerc_simulation
    __del__ = lambda self : None;
playerc_simulation_swigregister = _playerc.playerc_simulation_swigregister
playerc_simulation_swigregister(playerc_simulation)

class playerc_speech(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_speech, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_speech, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_speech_info_set
    __swig_getmethods__["info"] = _playerc.playerc_speech_info_get
    if _newclass:info = property(_playerc.playerc_speech_info_get, _playerc.playerc_speech_info_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_speech(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_speech_destroy(*args)
    def subscribe(*args): return _playerc.playerc_speech_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_speech_unsubscribe(*args)
    def say(*args): return _playerc.playerc_speech_say(*args)
    __swig_destroy__ = _playerc.delete_playerc_speech
    __del__ = lambda self : None;
playerc_speech_swigregister = _playerc.playerc_speech_swigregister
playerc_speech_swigregister(playerc_speech)

class playerc_speechrecognition(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_speechrecognition, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_speechrecognition, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_speechrecognition_info_set
    __swig_getmethods__["info"] = _playerc.playerc_speechrecognition_info_get
    if _newclass:info = property(_playerc.playerc_speechrecognition_info_get, _playerc.playerc_speechrecognition_info_set)
    __swig_setmethods__["rawText"] = _playerc.playerc_speechrecognition_rawText_set
    __swig_getmethods__["rawText"] = _playerc.playerc_speechrecognition_rawText_get
    if _newclass:rawText = property(_playerc.playerc_speechrecognition_rawText_get, _playerc.playerc_speechrecognition_rawText_set)
    __swig_setmethods__["words"] = _playerc.playerc_speechrecognition_words_set
    __swig_getmethods__["words"] = _playerc.playerc_speechrecognition_words_get
    if _newclass:words = property(_playerc.playerc_speechrecognition_words_get, _playerc.playerc_speechrecognition_words_set)
    __swig_setmethods__["wordCount"] = _playerc.playerc_speechrecognition_wordCount_set
    __swig_getmethods__["wordCount"] = _playerc.playerc_speechrecognition_wordCount_get
    if _newclass:wordCount = property(_playerc.playerc_speechrecognition_wordCount_get, _playerc.playerc_speechrecognition_wordCount_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_speechrecognition(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_speechrecognition_destroy(*args)
    def subscribe(*args): return _playerc.playerc_speechrecognition_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_speechrecognition_unsubscribe(*args)
    __swig_destroy__ = _playerc.delete_playerc_speechrecognition
    __del__ = lambda self : None;
playerc_speechrecognition_swigregister = _playerc.playerc_speechrecognition_swigregister
playerc_speechrecognition_swigregister(playerc_speechrecognition)

class playerc_rfidtag(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_rfidtag, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_rfidtag, name)
    __repr__ = _swig_repr
    __swig_setmethods__["type"] = _playerc.playerc_rfidtag_type_set
    __swig_getmethods__["type"] = _playerc.playerc_rfidtag_type_get
    if _newclass:type = property(_playerc.playerc_rfidtag_type_get, _playerc.playerc_rfidtag_type_set)
    __swig_setmethods__["guid_count"] = _playerc.playerc_rfidtag_guid_count_set
    __swig_getmethods__["guid_count"] = _playerc.playerc_rfidtag_guid_count_get
    if _newclass:guid_count = property(_playerc.playerc_rfidtag_guid_count_get, _playerc.playerc_rfidtag_guid_count_set)
    __swig_setmethods__["guid"] = _playerc.playerc_rfidtag_guid_set
    __swig_getmethods__["guid"] = _playerc.playerc_rfidtag_guid_get
    if _newclass:guid = property(_playerc.playerc_rfidtag_guid_get, _playerc.playerc_rfidtag_guid_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_rfidtag(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _playerc.delete_playerc_rfidtag
    __del__ = lambda self : None;
playerc_rfidtag_swigregister = _playerc.playerc_rfidtag_swigregister
playerc_rfidtag_swigregister(playerc_rfidtag)

class playerc_rfid(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_rfid, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_rfid, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_rfid_info_set
    __swig_getmethods__["info"] = _playerc.playerc_rfid_info_get
    if _newclass:info = property(_playerc.playerc_rfid_info_get, _playerc.playerc_rfid_info_set)
    __swig_setmethods__["tags_count"] = _playerc.playerc_rfid_tags_count_set
    __swig_getmethods__["tags_count"] = _playerc.playerc_rfid_tags_count_get
    if _newclass:tags_count = property(_playerc.playerc_rfid_tags_count_get, _playerc.playerc_rfid_tags_count_set)
    __swig_setmethods__["tags"] = _playerc.playerc_rfid_tags_set
    __swig_getmethods__["tags"] = _playerc.playerc_rfid_tags_get
    if _newclass:tags = property(_playerc.playerc_rfid_tags_get, _playerc.playerc_rfid_tags_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_rfid(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_rfid_destroy(*args)
    def subscribe(*args): return _playerc.playerc_rfid_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_rfid_unsubscribe(*args)
    __swig_destroy__ = _playerc.delete_playerc_rfid
    __del__ = lambda self : None;
playerc_rfid_swigregister = _playerc.playerc_rfid_swigregister
playerc_rfid_swigregister(playerc_rfid)

class playerc_pointcloud3d(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_pointcloud3d, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_pointcloud3d, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_pointcloud3d_info_set
    __swig_getmethods__["info"] = _playerc.playerc_pointcloud3d_info_get
    if _newclass:info = property(_playerc.playerc_pointcloud3d_info_get, _playerc.playerc_pointcloud3d_info_set)
    __swig_setmethods__["points_count"] = _playerc.playerc_pointcloud3d_points_count_set
    __swig_getmethods__["points_count"] = _playerc.playerc_pointcloud3d_points_count_get
    if _newclass:points_count = property(_playerc.playerc_pointcloud3d_points_count_get, _playerc.playerc_pointcloud3d_points_count_set)
    __swig_setmethods__["points"] = _playerc.playerc_pointcloud3d_points_set
    __swig_getmethods__["points"] = _playerc.playerc_pointcloud3d_points_get
    if _newclass:points = property(_playerc.playerc_pointcloud3d_points_get, _playerc.playerc_pointcloud3d_points_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_pointcloud3d(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_pointcloud3d_destroy(*args)
    def subscribe(*args): return _playerc.playerc_pointcloud3d_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_pointcloud3d_unsubscribe(*args)
    __swig_destroy__ = _playerc.delete_playerc_pointcloud3d
    __del__ = lambda self : None;
playerc_pointcloud3d_swigregister = _playerc.playerc_pointcloud3d_swigregister
playerc_pointcloud3d_swigregister(playerc_pointcloud3d)

class playerc_stereo(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_stereo, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_stereo, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_stereo_info_set
    __swig_getmethods__["info"] = _playerc.playerc_stereo_info_get
    if _newclass:info = property(_playerc.playerc_stereo_info_get, _playerc.playerc_stereo_info_set)
    __swig_setmethods__["left_channel"] = _playerc.playerc_stereo_left_channel_set
    __swig_getmethods__["left_channel"] = _playerc.playerc_stereo_left_channel_get
    if _newclass:left_channel = property(_playerc.playerc_stereo_left_channel_get, _playerc.playerc_stereo_left_channel_set)
    __swig_setmethods__["right_channel"] = _playerc.playerc_stereo_right_channel_set
    __swig_getmethods__["right_channel"] = _playerc.playerc_stereo_right_channel_get
    if _newclass:right_channel = property(_playerc.playerc_stereo_right_channel_get, _playerc.playerc_stereo_right_channel_set)
    __swig_setmethods__["disparity"] = _playerc.playerc_stereo_disparity_set
    __swig_getmethods__["disparity"] = _playerc.playerc_stereo_disparity_get
    if _newclass:disparity = property(_playerc.playerc_stereo_disparity_get, _playerc.playerc_stereo_disparity_set)
    __swig_setmethods__["points_count"] = _playerc.playerc_stereo_points_count_set
    __swig_getmethods__["points_count"] = _playerc.playerc_stereo_points_count_get
    if _newclass:points_count = property(_playerc.playerc_stereo_points_count_get, _playerc.playerc_stereo_points_count_set)
    __swig_setmethods__["points"] = _playerc.playerc_stereo_points_set
    __swig_getmethods__["points"] = _playerc.playerc_stereo_points_get
    if _newclass:points = property(_playerc.playerc_stereo_points_get, _playerc.playerc_stereo_points_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_stereo(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_stereo_destroy(*args)
    def subscribe(*args): return _playerc.playerc_stereo_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_stereo_unsubscribe(*args)
    __swig_destroy__ = _playerc.delete_playerc_stereo
    __del__ = lambda self : None;
playerc_stereo_swigregister = _playerc.playerc_stereo_swigregister
playerc_stereo_swigregister(playerc_stereo)

class playerc_imu(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_imu, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_imu, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_imu_info_set
    __swig_getmethods__["info"] = _playerc.playerc_imu_info_get
    if _newclass:info = property(_playerc.playerc_imu_info_get, _playerc.playerc_imu_info_set)
    __swig_setmethods__["pose"] = _playerc.playerc_imu_pose_set
    __swig_getmethods__["pose"] = _playerc.playerc_imu_pose_get
    if _newclass:pose = property(_playerc.playerc_imu_pose_get, _playerc.playerc_imu_pose_set)
    __swig_setmethods__["vel"] = _playerc.playerc_imu_vel_set
    __swig_getmethods__["vel"] = _playerc.playerc_imu_vel_get
    if _newclass:vel = property(_playerc.playerc_imu_vel_get, _playerc.playerc_imu_vel_set)
    __swig_setmethods__["acc"] = _playerc.playerc_imu_acc_set
    __swig_getmethods__["acc"] = _playerc.playerc_imu_acc_get
    if _newclass:acc = property(_playerc.playerc_imu_acc_get, _playerc.playerc_imu_acc_set)
    __swig_setmethods__["calib_data"] = _playerc.playerc_imu_calib_data_set
    __swig_getmethods__["calib_data"] = _playerc.playerc_imu_calib_data_get
    if _newclass:calib_data = property(_playerc.playerc_imu_calib_data_get, _playerc.playerc_imu_calib_data_set)
    __swig_setmethods__["q0"] = _playerc.playerc_imu_q0_set
    __swig_getmethods__["q0"] = _playerc.playerc_imu_q0_get
    if _newclass:q0 = property(_playerc.playerc_imu_q0_get, _playerc.playerc_imu_q0_set)
    __swig_setmethods__["q1"] = _playerc.playerc_imu_q1_set
    __swig_getmethods__["q1"] = _playerc.playerc_imu_q1_get
    if _newclass:q1 = property(_playerc.playerc_imu_q1_get, _playerc.playerc_imu_q1_set)
    __swig_setmethods__["q2"] = _playerc.playerc_imu_q2_set
    __swig_getmethods__["q2"] = _playerc.playerc_imu_q2_get
    if _newclass:q2 = property(_playerc.playerc_imu_q2_get, _playerc.playerc_imu_q2_set)
    __swig_setmethods__["q3"] = _playerc.playerc_imu_q3_set
    __swig_getmethods__["q3"] = _playerc.playerc_imu_q3_get
    if _newclass:q3 = property(_playerc.playerc_imu_q3_get, _playerc.playerc_imu_q3_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_imu(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_imu_destroy(*args)
    def subscribe(*args): return _playerc.playerc_imu_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_imu_unsubscribe(*args)
    def datatype(*args): return _playerc.playerc_imu_datatype(*args)
    def reset_orientation(*args): return _playerc.playerc_imu_reset_orientation(*args)
    __swig_destroy__ = _playerc.delete_playerc_imu
    __del__ = lambda self : None;
playerc_imu_swigregister = _playerc.playerc_imu_swigregister
playerc_imu_swigregister(playerc_imu)

class playerc_wsn(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, playerc_wsn, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, playerc_wsn, name)
    __repr__ = _swig_repr
    __swig_setmethods__["info"] = _playerc.playerc_wsn_info_set
    __swig_getmethods__["info"] = _playerc.playerc_wsn_info_get
    if _newclass:info = property(_playerc.playerc_wsn_info_get, _playerc.playerc_wsn_info_set)
    __swig_setmethods__["node_type"] = _playerc.playerc_wsn_node_type_set
    __swig_getmethods__["node_type"] = _playerc.playerc_wsn_node_type_get
    if _newclass:node_type = property(_playerc.playerc_wsn_node_type_get, _playerc.playerc_wsn_node_type_set)
    __swig_setmethods__["node_id"] = _playerc.playerc_wsn_node_id_set
    __swig_getmethods__["node_id"] = _playerc.playerc_wsn_node_id_get
    if _newclass:node_id = property(_playerc.playerc_wsn_node_id_get, _playerc.playerc_wsn_node_id_set)
    __swig_setmethods__["node_parent_id"] = _playerc.playerc_wsn_node_parent_id_set
    __swig_getmethods__["node_parent_id"] = _playerc.playerc_wsn_node_parent_id_get
    if _newclass:node_parent_id = property(_playerc.playerc_wsn_node_parent_id_get, _playerc.playerc_wsn_node_parent_id_set)
    __swig_setmethods__["data_packet"] = _playerc.playerc_wsn_data_packet_set
    __swig_getmethods__["data_packet"] = _playerc.playerc_wsn_data_packet_get
    if _newclass:data_packet = property(_playerc.playerc_wsn_data_packet_get, _playerc.playerc_wsn_data_packet_set)
    def __init__(self, *args): 
        this = _playerc.new_playerc_wsn(*args)
        try: self.this.append(this)
        except: self.this = this
    def destroy(*args): return _playerc.playerc_wsn_destroy(*args)
    def subscribe(*args): return _playerc.playerc_wsn_subscribe(*args)
    def unsubscribe(*args): return _playerc.playerc_wsn_unsubscribe(*args)
    def set_devstate(*args): return _playerc.playerc_wsn_set_devstate(*args)
    def power(*args): return _playerc.playerc_wsn_power(*args)
    def datatype(*args): return _playerc.playerc_wsn_datatype(*args)
    def datafreq(*args): return _playerc.playerc_wsn_datafreq(*args)
    __swig_destroy__ = _playerc.delete_playerc_wsn
    __del__ = lambda self : None;
playerc_wsn_swigregister = _playerc.playerc_wsn_swigregister
playerc_wsn_swigregister(playerc_wsn)



