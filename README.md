PhotoView Binding for Xamarin
=============================

Xamarin bindings library for the Android [AwesomeImagePicker library](https://github.com/myinnos/AwesomeImagePicker).

Plugin is available on [Nuget](https://www.nuget.org/packages/Xamarin.Bindings.Android.AwesomeImagePicker/).

Installation
------------
    Install-Package Xamarin.Bindings.Android.AwesomeImagePicker

Usage
-----
For details, please see the [original PhotoView documentation](https://github.com/myinnos/AwesomeImagePicker#how-to-use).

**Step 1**: start intent to open awesome image picker gallery:
```CSharp
using IN.Myinnos.Awesomeimagepicker.Activities;
using IN.Myinnos.Awesomeimagepicker.Helpers;

...

var intent = new Intent(this, typeof(AlbumSelectActivity));
// set limit for image selection
intent.PutExtra(ConstantsCustomGallery.IntentExtraLimit, 100); 
this.StartActivityForResult(intent, ConstantsCustomGallery.RequestCode);
```

**Step 2**: OnActivityResult :
```csharp
using IN.Myinnos.Awesomeimagepicker.Models;
using IN.Myinnos.Awesomeimagepicker.Helpers;

...

public override void OnActivityResult(int requestCode, int resultCode, Intent data) 
{
    super.onActivityResult(requestCode, resultCode, data);

    if (requestCode == ConstantsCustomGallery.RequestCode && resultCode == Activity.ResultOk && data != null) 
    {
        //The array list has the image paths of the selected images
        var urls = data.GetParcelableArrayListExtra(ConstantsCustomGallery.IntentExtraImages)
                       .Cast<Image>()
                       .Select(i => Uri.FromFile(new File(i.Path)));
    }
}
```
Build
-----
To automatically download the latest AAR, update the version information in AssemlyInfo.cs and the nuspec file and then build and package the binding assembly, just run `build.bat` in the Visual Studio Developer Command Prompt.

License
--------

    Copyright 2017 Munir Husseini

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
