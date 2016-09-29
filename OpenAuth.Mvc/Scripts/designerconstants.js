var WorkflowDesignerConstants = {
    SelectColor: 'purple',
    ActivityColor: '#F2F2F2',
    ActivityInitialColor: '#00ff00',
    ActivityFinalColor: '#ff0000',
    ActivityCurrentColor: '#00CCCC',

    DeleteConfirm: '确定要删除所选项?',
    FieldIsRequired: 'Field is required!',
    FieldMustBeUnique: 'Field must be unique!',
    ButtonTextDelete: '删除',
    ButtonTextCreate: '创建',

    InfoBlockLabel: {
        Activity: '节点: ',
        Transition: '状态转换: ',
        Command: '命令: ',
    },

    ActivityNamePrefix: 'Activity_',
    ActivityFormLabel: {
        Title: '节点',
        Name: '名称',
        State: '状态',
        IsInitial: '是否为初始节点',
        IsFinal: '是否为完成节点',
        IsForSetState: '是否修改状态',
        IsAutoSchemeUpdate: '是否自动更新',
        Implementation: '执行操作',
        PreExecutionImplementation: '提前执行操作',
        ImpOrder: '序号',
        ImpAction: '操作',
        ImpActionParameter: '操作参数',
        AlwaysConditionShouldBeSingle: 'Always condition should be single',
        OtherwiseConditionShouldBeSingle: 'Otherwise condition should be single'

    },

    TransitionFormLabel: {
        Title: '状态转换',
        Name: '名称',
        From: '上一步',
        To: '下一步',
        Classifier: '类型',
        Restrictions: '限制条件',
        RestrictionsType: '类型',
        RestrictionsActor: '执行人',
        Condition: '转换条件',
        ConditionType: '类型',
        ConditionAction: '操作',
        ResultOnPreExecution: 'Result on PreExecution',
        Trigger: '触发',
        TriggerType: '触发类型',
        TriggerCommand: '命令',
        TriggerTimer: '定时',
        ConditionActionParameter: '操作参数',
        ConditionInversion: '转换执行结果',
        ConditionsConcatenationType: 'Conditions concatenation type',
        AllowConcatenationType: 'Concat allow as',
        RestrictConcatenationType: 'Concat restrict as',
        ConditionsListShouldNotBeEmpty: 'Conditions list should not be empty',
        IsFork: 'Is fork',
        MergeViaSetState: 'Merge subprocess via set state',
        DisableParentStateControl: 'Disable parent process control'

    },
    LocalizationFormLabel: {
        Title: 'Localization',
        ObjectName: 'ObjectName',
        Type: 'Type',
        IsDefault: 'IsDefault',
        Culture: 'Culture',
        Value: 'Value',
        Types: ['Command', 'State', 'Parameter'],
    },

    TimerFormLabel: {
        Title: 'Timers',
        Name: 'Name',
        Type: 'Type',
        Value: 'Value',
        Types: ['Command', 'State', 'Parameter'],
        NotOverrideIfExists: "Do not override timer if exists"
    },

    ParameterFormLabel: {
        Title: '系统参数',
        Name: 'Name',
        Type: 'Type',
        Purpose: 'Purpose',
        Value: 'Value',
        InitialValue: '默认值'
    },

    ActorFormLabel: {
        Title: '执行人',
        Name: '名称',
        Rule: 'Rule',
        Value: 'Value'
    },

    CommandFormLabel: {
        Title: '命令',
        Name: "名称",
        InputParameters: "Input Parameters",
        InputParametersName: 'Name',
        InputParametersParameter: 'Parameter'
    },

    AdditionalParamsFormLabel: {
        Title: 'Additional Parameters',
        IsObsolete: "IsObsolete",
        DefiningParameters: 'Defining parameters',
        ProcessParameters: 'Process parameters',
        ProcessParametersName: 'Name',
        ProcessParametersValue: 'Value'
    },
    CodeActionsFormLabel: {
        Title: '代码片段',
        Name: 'Name',
        ActionCode: 'Action code',
        IsGlobal: 'Is global',
        Type: 'Type'
    },

    ToolbarLabel: {
        CreateActivity: '创建节点',
        CopySelected: '复制所选',
        Undo: '撤销',
        Redo: '重做',
        Move: '移动',
        ZoomIn: '放大',
        ZoomOut: '缩小',
        ZoomPositionDefault: '默认大小',
        AutoArrangement: '自动排列',
        Actors: '执行人',
        Commands: '命令',
        Parameters: '参数',
        Localization: '本地化',
        Timers: '定时器',
        AdditionalParameters: '附加参数',
        CodeActions: '代码片段'
    },
    ErrorActivityIsInitialCountText: "One element must be marked flag Initial",
    ErrorReadOnlySaveText: "The Designer in ReadOnly mode, you can't save it.",
    FormMaxHeight: 500,
    EditCodeSettings: {
        Height: 600,
        Width: 1000,
        CodeHeight: 390,
        MessageBoxHeight: 400,
        MessageBoxWidth: 600,
        SuccessBoxHeight: 150,
        SuccessBoxWidth: 300
    },
    EditCodeLabel: {
        Title: "Edit code",
        EditCodeButton: 'Edit code',
        Usings: 'Usings',
        Compile: "Compile",
        CompileSucceeded: "Compilation succeeded.",
        Success: "Success",
        Error: "Error",
        OK: "OK"
    },

    EditJSONSettings: {
        Height: 600,
        Width: 1000,
        CodeHeight: 390,
        MessageBoxHeight: 400,
        MessageBoxWidth: 600,
        SuccessBoxHeight: 150,
        SuccessBoxWidth: 300
    },
    EditJSONLabel: {
        Title: "Edit code",
        EditCodeButton: 'Edit code',
        Usings: 'Usings',
        Compile: "Compile",
        CompileSucceeded: "Compilation succeeded.",
        Success: "Success",
        Error: "Error",
        OK: "OK"
    }
};